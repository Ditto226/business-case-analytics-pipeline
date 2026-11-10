let
    
    //assuming the reporting date is working day for all state (slight inaccurate)
    #"Added CRT1" = Table.AddColumn(
        CI, 
        "CRT1", 
        each 
            if [Type0] = "Non-Tech" and [CASE_STATUS] = "Closed" and [BUSINESS_DAY_AGING] <= 3 then
                "Meet"
            else if [Type0] = "Non-Tech" and ([CASE_STATUS] = "Processing" or [CASE_STATUS] = "IRIS - Closed") and [BUSINESS_DAY_AGING] <= 3 then
                "Potential"
            else if [Type0] = "Tech" and [CASE_STATUS] = "Closed" and [CASE_AGING_CAL_DAYS] <= 1 then
                "Meet"
            else if [Type0] = "Tech" and ([CASE_STATUS] = "Processing" or [CASE_STATUS] = "IRIS - Closed") and [CASE_AGING_CAL_DAYS] <= 1 then
                "Potential"
            else
                "Not Meet",
        type text
    ),
    #"Added CRT2" = Table.AddColumn(
        #"Added CRT1", 
        "CRT2", 
        each 
            if [Type0] = "Non-Tech" and [CASE_STATUS] = "Closed" and [BUSINESS_DAY_AGING] <= 10 then
                "Meet"
            else if [Type0] = "Non-Tech" and ([CASE_STATUS] = "Processing" or [CASE_STATUS] = "IRIS - Closed") and [BUSINESS_DAY_AGING] <= 10 then
                "Potential"
            else if [Type0] = "Tech" and [CASE_STATUS] = "Closed" and [BUSINESS_DAY_AGING] <= 3 then
                "Meet"
            else if [Type0] = "Tech" and ([CASE_STATUS] = "Processing" or [CASE_STATUS] = "IRIS - Closed") and [BUSINESS_DAY_AGING] <= 3 then
                "Potential"
            else
                "Not Meet",
        type text
    ),
    #"Unpivoted Columns" = Table.UnpivotOtherColumns(#"Added CRT2", {"CASE_CREATED_ON - Year", "CASE_CREATED_ON - Month", "CASE_CREATED_ON - Day", "ACCOUNT_NO", "CASE_ID", "CASE_TITLE", "CREATED_BY", "CREATOR_BUSINESS_UNIT", "CASE_AREA", "CASE_TYPE", "CASE_CATEGORY", "CASE_SUB_CATEGORY", "CASE_SUB_AREA", "SOURCE", "CASE_STATUS", "CASE_OWNER_STAFF", "CASE_OWNER_BUSINESS_UNIT", "BUSINESS_DAY_AGING", "CASE_AGING_CAL_DAYS", "BUSS AGING RANGE", "Average of Index.2", "Week", "Clean Case Type", "Type0", "Date_Creation", "LOV", "BUSINESS_DAY_AGING_OG"}, "Performance", "CRT_Status"),
    #"Replaced Value" = Table.ReplaceValue(#"Unpivoted Columns","CRT","",Replacer.ReplaceText,{"Performance"}),
    // #"Added Conditional Column" = Table.AddColumn(#"Replaced Value", "Counter CRT", each if [Performance] = "1" then [Counter CRT1] else if [Performance] = "2" then [Counter CRT2] else null),
    SLADays = Table.AddColumn(#"Replaced Value", "SLADays", each 
    if [BUSINESS_DAY_AGING] = null or ([Performance] = "1" and [Type0] = "Tech") then 
        [CASE_AGING_CAL_DAYS]
else
    // else if [Performance] = "1" or [Performance] = "2"  then 
        [BUSINESS_DAY_AGING]
    // else 
    //     null
, Int64.Type
),
    #"Added Counter CRT" = Table.AddColumn(
    SLADays, 
    "Counter CRT", 
    each 
        if [CASE_STATUS] <> "Processing" then null
        else if [Performance] = "1" then
            if ([Type0] = "Tech" and [SLADays] = 1) or ([Type0] = "Non-Tech" and [SLADays] = 3) then "Today"
            else if ([Type0] = "Tech" and [SLADays] = 0) or ([Type0] = "Non-Tech" and [SLADays] = 2) then "Next BD"
            else "Others"
        else if [Performance] = "2" then
            if ([Type0] = "Tech" and [SLADays] = 3) or ([Type0] = "Non-Tech" and [SLADays] = 10) then "Today"
            else if ([Type0] = "Tech" and [SLADays] = 2) or ([Type0] = "Non-Tech" and [SLADays] = 9) then "Next BD"
            else "Others"
        else null,
    type text
),
    KeyValue = Table.AddColumn(#"Added Counter CRT", "KeyValue", each Text.Combine({ [Type0],[Performance]}, "_"), type text)
in
    KeyValue