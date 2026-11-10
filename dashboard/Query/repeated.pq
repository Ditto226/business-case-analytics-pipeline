let
    
    //test for correct repeat value

    SortedRows = Table.Sort(CI, {
        {"ACCOUNT_NO", Order.Ascending}, 
        {"LOV", Order.Ascending}, 
        {"Date_Creation", Order.Ascending}
    }),
    
    // Call the function
    RepeatedLOV = Repeated(
        SortedRows, 
        {"ACCOUNT_NO", "LOV"}, 
        "Date_Creation", 
        90
    ),

    RepeatedTech = Repeated(
        RepeatedLOV, 
        {"ACCOUNT_NO", "Type0"}, 
        "Date_Creation", 
        90
    ),
    
    #"Unpivoted Columns" = Table.UnpivotOtherColumns(RepeatedTech, {"CASE_CREATED_ON - Year", "CASE_CREATED_ON - Month", "CASE_CREATED_ON - Day", "ACCOUNT_NO", "CASE_ID", "CASE_TITLE", "CREATED_BY", "CREATOR_BUSINESS_UNIT", "CASE_AREA", "CASE_TYPE", "CASE_CATEGORY", "CASE_SUB_CATEGORY", "CASE_SUB_AREA", "SOURCE", "CASE_STATUS", "CASE_OWNER_STAFF", "CASE_OWNER_BUSINESS_UNIT", "BUSINESS_DAY_AGING", "CASE_AGING_CAL_DAYS", "BUSS AGING RANGE", "Average of Index.2", "Date_Creation", "Week", "LOV", "Type0", "Clean Case Type", "BUSINESS_DAY_AGING_OG"}, "Repeat", "Repeat Count"),

    #"Replaced Value" = Table.ReplaceValue(#"Unpivoted Columns","Repeated","",Replacer.ReplaceText,{"Repeat"}),
    // 5. Add your final grouping category directly (e.g., 1, 2, 3+)
    AddRepeatCategory = Table.AddColumn(
        #"Replaced Value",
        "Repeat Group",
        each 
            if [Repeat Count] >= 2 then "2+"
            else if [Repeat Count] > 0 then Text.From([Repeat Count])
            else "0",
        type text
    ),
    KeyValue = Table.AddColumn(AddRepeatCategory, "KeyValue", each Text.Combine({ [Type0],[Repeat]}, "_"), type text)
in
    KeyValue