package it.unige.fdt.scriptablesensor.model;

public class SensorFeatureUpdateMessage<T> {

    private final T payload;
    private final Class<T> payloadClass;
    private final String featureName;
    private final String propertyName;

    @SuppressWarnings("unchecked")
    public SensorFeatureUpdateMessage(T payload, String featureName, String propertyName) {
	this.payload = payload;
	this.payloadClass = (Class<T>) payload.getClass();
	this.featureName = featureName;
	this.propertyName = propertyName;
    }

    public T getPayload() {
	return payload;
    }

    public Class<T> getPayloadClass() {
	return payloadClass;
    }

    public String getFeatureName() {
	return featureName;
    }

    public String getPropertyName() {
	return propertyName;
    }

    @Override
    public String toString() {
	return "SensorFeatureUpdateMessage [payload=" + payload + ", payloadClass=" + payloadClass.getName()
		+ ", featureName=" + featureName + ", propertyName=" + propertyName + "]";
    }

}
