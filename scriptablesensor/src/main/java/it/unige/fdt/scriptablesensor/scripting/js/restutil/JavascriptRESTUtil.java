package it.unige.fdt.scriptablesensor.scripting.js.restutil;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpClient.Redirect;
import java.net.http.HttpClient.Version;
import java.net.http.HttpHeaders;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.security.KeyManagementException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.time.Duration;
import java.util.Base64;
import java.util.Collections;
import java.util.Optional;
import java.util.concurrent.Executor;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.eclipse.microprofile.config.Config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class JavascriptRESTUtil {
	
	private static Logger LOGGER = LoggerFactory.getLogger(JavascriptRESTUtil.class);
	
	@Inject
	Executor executor;
	
	@Inject
	Config config;
	
	private SSLContext getInsecureSSLContext() {
		try {
			SSLContext context = SSLContext.getInstance("TLS");
			TrustManager[] trustManagers = new TrustManager[] {
				new X509TrustManager() {
					@Override
					public X509Certificate[] getAcceptedIssuers() {
						return new X509Certificate[] {};
					}
					@Override
					public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
						// Do nothing
					}
					@Override
					public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
						// Do nothing
					}
				}
			};
			context.init(null, trustManagers, SecureRandom.getInstanceStrong());
			return context;
		} catch (NoSuchAlgorithmException | KeyManagementException e) {
			throw new RuntimeException(e);
		}
	}
	
	private HttpClient getHttpClient() {
		HttpClient.Builder httpClientBuilder = HttpClient.newBuilder()
				.followRedirects(Redirect.NORMAL)
				.connectTimeout(Duration.ofSeconds(5L))
				.executor(executor);
		if (config.getOptionalValue("fdt.restutil.insecure", Boolean.class).orElse(false)) {
			LOGGER.warn("Insecure certificate validation is enabled");
			httpClientBuilder.sslContext(getInsecureSSLContext());
		}
		return httpClientBuilder.build();
	}
	
	public HttpResponse<String> doGet(String url) throws IOException, InterruptedException {
		HttpClient httpClient = getHttpClient();
		HttpRequest httpRequest = HttpRequest.newBuilder()
				.GET()
				.uri(URI.create(url))
				.build();
		return httpClient.send(httpRequest, BodyHandlers.ofString());
	}

	public HttpResponse<String> doCacheableGet(String url) throws IOException, InterruptedException, NoSuchAlgorithmException {
		// Get hash of the URL
		MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
		messageDigest.update(url.getBytes(StandardCharsets.UTF_8));
		byte[] digest = messageDigest.digest();
		BigInteger hashNumber = new BigInteger(digest);
		String hash = hashNumber.toString(16);
		LOGGER.debug("Hash of {} is {}", url, hash);
		// Try to find it inside of cache
		String cacheBase = System.getProperty("deployment.user.cachedir", "/var/cache");
		Path cachePath = Path.of(cacheBase, "scriptablesensor");
		if (!cachePath.toFile().isDirectory()) {
			cachePath.toFile().mkdir();
			LOGGER.info("Created cache directory ({})", cachePath.toAbsolutePath().toString());
		}
		Path cachedFilePath = cachePath.resolve(hash);
		if (cachedFilePath.toFile().isFile()) {
			LOGGER.info("Found cached response for {} in {}", url, cachedFilePath.toString());
			String cachedContent = Files.readString(cachedFilePath);
			return new HttpResponse<String>() {

				@Override
				public String body() {
					return cachedContent;
				}

				@Override
				public HttpHeaders headers() {
					return HttpHeaders.of(Collections.emptyMap(), (k,v) -> true);
				}

				@Override
				public Optional<HttpResponse<String>> previousResponse() {
					return Optional.empty();
				}

				@Override
				public HttpRequest request() {
					return HttpRequest.newBuilder(uri()).GET().build();
				}

				@Override
				public Optional<SSLSession> sslSession() {
					return Optional.empty();
				}

				@Override
				public int statusCode() {
					return 200;
				}

				@Override
				public URI uri() {
					return URI.create(url);
				}

				@Override
				public Version version() {
					return Version.HTTP_1_1;
				}
			};
		}
		// Fallback to the original method
		LOGGER.info("Cache miss for {} ({})", url, cachedFilePath.toString());
		HttpResponse<String> response = doGet(url);
		// Save to cache
		Files.writeString(cachedFilePath, response.body(), StandardOpenOption.WRITE);
		LOGGER.info("Saved response for {} to {}", url, cachedFilePath.toString());
		// Return the original response
		return response;
	}

}
