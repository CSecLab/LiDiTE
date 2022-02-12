(function fdtInterop() {
  // Settings
  const latitude = 44.18
  const longitude = 8.18
  const reference_year = 2016
  const azimuth = -30
  const rise = 15
  // State
  let data = null
  // Helpers
  function grabSolarData() {
    const response = RESTUtil.doCacheableGet(`https://re.jrc.ec.europa.eu/api/seriescalc?lat=${latitude}&lon=${longitude}&outputformat=json&startyear=${reference_year}&endyear=${reference_year}&tracking=0&angle=${rise}&aspect=${azimuth}`)
    const responseJson = JSON.parse(response.body())
    const data_rows_raw = responseJson.outputs.hourly
    function parse_row(row) {
      function parse_date() {
        // 2 0 1 5 0 1 0 5 : 0 2  5  2
        // 0 1 2 3 4 5 6 7 8 9 10 11 12
        const timeS = row.time

        const y = parseInt(timeS.substring(0, 4))
        const m = parseInt(timeS.substring(4, 6))
        const d = parseInt(timeS.substring(6, 8))

        console.assert(timeS.charAt(8) == ':', `Time string ${timeS} could not be parsed`)

        const hh = parseInt(timeS.substring(9, 11))
        const mm = parseInt(timeS.substring(11, 13))

        return new Date(y, m, d, hh, mm, 0, 0)
      }
      row.time = parse_date()
      return row
    }
    return data_rows_raw
      // Parse dates
      .map(parse_row)
      // Get only reference year
      .filter(row => row.time.getFullYear() === reference_year)
      // Sort by date
      .sort((a,b) => a.time.getTime() - b.time.getTime())
  }
  function getCurrentConditions() {
    // Get data if absent
    if (!data) {
      console.log('Fetching solar data')
      data = grabSolarData()
      console.log(`Fetched solar data, ${data.length} records, first: ${data[0].time}, last: ${data[data.length - 1].time}`)
    }
    // Get now
    const now = new Date(Date.now())
    // Force now to be in the reference year
    now.setFullYear(reference_year)
    // Sort for closeness
    data = data.sort((a, b) => {
      const distanceA = Math.abs(now - a.time);
      const distanceB = Math.abs(now - b.time);
      return distanceA - distanceB
    })
    // Get data for the closest intervals
    let dateBefore = data.filter(d => d.time <= now)
    let dateAfter = data.filter(d => d.time >= now)
    if (dateBefore.length === 0 && dateAfter.length !== 0) {
      // No date before exists
      dateBefore = dateAfter[0]
      dateAfter = dateAfter[0]
    } else if (dateBefore.length !== 0 && dateAfter.length === 0) {
      // No date after exists
      dateBefore = dateBefore[0]
      dateAfter = dateBefore[0]
    } else {
      // Both dates exists
      dateBefore = dateBefore[0]
      dateAfter = dateAfter[0]
    }
    // Calculate linear interpolation
    const interpolatedCondition = {
      time: now
    }
    for (const key in dateBefore) {
      if (key === 'time') continue
      const xNow = now
      const xBefore = dateBefore['time']
      const xAfter = dateAfter['time']
      const valueBefore = dateBefore[key]
      const valueAfter = dateAfter[key]

      const interpolatedValue = valueBefore + (xNow - xBefore) * ((valueAfter - valueBefore)/(xAfter - xBefore))
      interpolatedCondition[key] = interpolatedValue
    }
    // Get data for the closest date
    console.log(`Current condition (${now.toISOString()}): ${JSON.stringify(interpolatedCondition)} interpolated between ${JSON.stringify(dateBefore)} and ${JSON.stringify(dateAfter)}`)
    return interpolatedCondition
  }
  // Exported functions
  const functions = {
    wattPerMsq: () => {
      const currentConditions = getCurrentConditions()
      return currentConditions['G(i)']
    },
    sunHeight: () => {
      const currentConditions = getCurrentConditions()
      return currentConditions['H_sun']
    }
  }
  return functions
})()