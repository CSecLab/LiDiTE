package it.unige.fdt.scriptablesensor.model.feature.lut.values;

import java.util.Comparator;
import java.util.Objects;
import java.util.regex.Pattern;

public class TimeValuePair implements Comparable<TimeValuePair> {

	protected final long minuteInDay;
	protected final double value;

	public TimeValuePair(long minuteInDay, double value) {
	    this.minuteInDay = minuteInDay;
	    this.value = value;
	}
	
	public TimeValuePair(String s, double value) {
		String[] timeStringComponents = s.split(Pattern.quote(":"), 2);
		int hourInDay = Integer.parseInt(timeStringComponents[0]);
		int minuteInHour = Integer.parseInt(timeStringComponents[1]);

		this.minuteInDay = ((long) (hourInDay * 60)) + (long) minuteInHour;
		this.value = value;
    }

	public long getMinuteInDay() {
	    return minuteInDay;
	}

	public double getValue() {
	    return value;
	}

	@Override
	public int hashCode() {
	    return Objects.hash(minuteInDay, value);
	}

	@Override
	public boolean equals(Object obj) {
	    if (this == obj) {
		return true;
	    }
	    if (!(obj instanceof TimeValuePair)) {
		return false;
	    }
	    TimeValuePair other = (TimeValuePair) obj;
	    return minuteInDay == other.minuteInDay
		    && Double.doubleToLongBits(value) == Double.doubleToLongBits(other.value);
	}

	@Override
	public int compareTo(TimeValuePair o) {
		return Comparator.comparing(TimeValuePair::getMinuteInDay).compare(this, o);
	}
}
