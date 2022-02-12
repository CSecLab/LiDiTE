package it.unige.fdt.scriptablesensor.scripting.js.restutil;

import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;

class InsecureSSLContextFactory {
	private InsecureSSLContextFactory() {}
	
	static SSLContext getInsecureSSLContext() throws NoSuchAlgorithmException, KeyManagementException {
		SSLContext defaultSSLContext = SSLContext.getDefault();
		SSLContext sslContext = SSLContext.getInstance(defaultSSLContext.getProtocol(), defaultSSLContext.getProvider());
		sslContext.init(null, new TrustManager[] { new InsecureTrustManager() }, SecureRandom.getInstanceStrong());
		return sslContext;
	}
}
