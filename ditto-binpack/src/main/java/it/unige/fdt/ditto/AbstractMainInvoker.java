package it.unige.fdt.ditto;

public abstract class AbstractMainInvoker implements Runnable {

    protected final Class<?> clazz;

    public AbstractMainInvoker(Class<?> clazz) {
	this.clazz = clazz;
    }
}
