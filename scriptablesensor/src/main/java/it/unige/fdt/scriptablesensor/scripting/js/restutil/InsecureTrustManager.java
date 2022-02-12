package it.unige.fdt.scriptablesensor.scripting.js.restutil;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.X509TrustManager;

class InsecureTrustManager implements X509TrustManager {

	@Override
	public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		// Do nothing
	}

	@Override
	public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		// Do nothing
	}

	@Override
	public X509Certificate[] getAcceptedIssuers() {
		return new X509Certificate[] {};
	}
	
}
