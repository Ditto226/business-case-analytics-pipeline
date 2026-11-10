= (StartDT as nullable date, EndDT as nullable date) as duration =>
let
    Result = 
        if StartDT = null or EndDT = null or StartDT >= EndDT then 
            #duration(0, 0, 0, 0)
        else
            let
                StartD = (StartDT),
                EndD   = (EndDT),
                RawDuration = EndDT-StartDT
            in 
                // Fast path: Same-day duration (~80% of rows) avoids all multi-day math
                if StartD = EndD then
                    if Date.DayOfWeek(StartD, Day.Monday) >= 5 or List.Contains(HOLIDAY, StartD) 
                    then #duration(0, 0, 0, 0) 
                    else RawDuration
                else
                    let
                        // 1. O(1) pure math for weekend days - ZERO list generation or closures
                        TotalDays       = Duration.Days(EndD - StartD) + 1,
                        StartDow        = Date.DayOfWeek(StartD, Day.Monday), // 0 = Mon, 6 = Sun
                        FullWeeks       = Number.IntegerDivide(TotalDays, 7),
                        RemainingDays   = Number.Mod(TotalDays, 7),
                        // Number of days into the weekend from the remaining window
                        SatOffset       = Number.Mod(5 - StartDow + 7, 7),
                        ExtraWeekendDays = 
                            (if RemainingDays > SatOffset then 1 else 0) + 
                            (if RemainingDays > Number.Mod(6 - StartDow + 7, 7) then 1 else 0),
                        WeekendCount    = (FullWeeks * 2) + ExtraWeekendDays,

                        // 2. Fast holiday filtering
                        // Ensure HOLIDAY is already filtered to only weekdays in its own query definition:
                        StartIsHoliday  = List.Contains(HOLIDAY, StartD),
                        EndIsHoliday    = List.Contains(HOLIDAY, EndD),
                        StartIsOff      = StartDow >= 5 or StartIsHoliday,
                        EndIsOff        = Date.DayOfWeek(EndD, Day.Monday) >= 5 or EndIsHoliday,

                        // Fast range count over pre-filtered weekday holidays
                        WeekdayHolidaysCount = List.Count(
                            List.Select(HOLIDAY, (h) => h >= StartD and h <= EndD)
                        ),

                        TotalNonWorkDays = WeekendCount + WeekdayHolidaysCount,

                        StartOffset = StartDT - (StartD),
                        EndOffset   = #duration(1, 0, 0, 0) - (EndDT - (EndD)),

                        Net = 
                            if StartD = EndD then
                                if StartIsOff then #duration(0, 0, 0, 0) else RawDuration
                            else
                                RawDuration 
                                - #duration(TotalNonWorkDays, 0, 0, 0)
                                + (if StartIsOff then StartOffset else #duration(0, 0, 0, 0))
                                + (if EndIsOff then EndOffset else #duration(0, 0, 0, 0))
                    in
                        if Net < #duration(0, 0, 0, 0) then #duration(0, 0, 0, 0) else Net
in
    Result