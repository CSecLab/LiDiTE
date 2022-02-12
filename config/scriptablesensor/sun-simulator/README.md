# sun-simulator

This component interacts with the PVGIS platform to download the solar radiance values for a given position on the globe.

Once such data has been obtained, the returned radiance is an interpolation between the values that in the original dataset are closest to the current day and time of the year.
