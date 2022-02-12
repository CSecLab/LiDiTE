(function fdtInterop() {
  // Solar panel areas
  const solarPanelSurfaces = [
    // Ferrania Solis AP60-240
    { surface: 490.6, efficiency: 0.1446 },
  ];
  // Helpers
  function calculateSolarSurfacePower(solarPanelSurface, currentWattsPerMsq) {
    const surface = solarPanelSurface.surface;
    const power = currentWattsPerMsq * surface;
    const effectivePower = power * solarPanelSurface.efficiency;
    // Log
    console.log(`s = ${surface}msq, maximum = ${power}W, effective = ${effectivePower}W`);
    // Return
    return { surface: surface, power: power, effectivePower: effectivePower };
  }
  // Function exported to FDT
  return {
    calculatePower: (currentWattsPerMsq) => {
      // State
      let totalSurface = 0.0;
      let totalTheoreticalPower = 0.0;
      let totalPower = 0.0;
      // For each solar panel
      for (const solarPanelSurface of solarPanelSurfaces) {
        const { surface, power, effectivePower } = calculateSolarSurfacePower(solarPanelSurface, currentWattsPerMsq);
        // Augment totals
        totalSurface += surface;
        totalTheoreticalPower += power;
        totalPower += effectivePower;
      }
      console.log(`SYSTEM s = ${totalSurface}msq, theoretical = ${totalTheoreticalPower}W, effective = ${totalPower}W`);
      return totalPower / 1000.0;
    },
    calculateSurfaceTemperature: (currentPower) => {
      return currentPower * 0.15 + 20;
    }
  }
})()