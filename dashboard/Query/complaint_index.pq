let
    Source = SharePoint.Contents([Credential),
    Documents = Source{[Name="Documents"]}[Content],
    DASHBOARD = Documents{[Name=[Me]]}[Content],
    DATA = Documents{[Name="DATA (PBI)"]}[Content],
    #"Sorted Files" = Table.Sort(DATA,{{"Date modified", Order.Descending}}),
    #"Filtered Files" = Table.FirstN(#"Sorted Files", 1),
    FileBinary = #"Filtered Files"{0}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(FileBinary, null, true),
    Table1_Table = #"Imported Excel Workbook"{[Item="Table1",Kind="Table"]}[Data],
    #"Inserted Date" = Table.AddColumn(Table1_Table, "Date_Creation", each Text.Combine({Text.From([#"CASE_CREATED_ON - Day"], "en-MY"), [#"CASE_CREATED_ON - Month"], Text.From([#"CASE_CREATED_ON - Year"], "en-MY")}, " "), type date),
    #"Added Week" = Table.AddColumn(#"Inserted Date", "Week", each let d = [#"CASE_CREATED_ON - Day"] in if d <= 7 then 1 else if d <= 14 then 2 else if d <= 21 then 3 else if d <= 28 then 4 else 5, Int64.Type),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Added Week", "CASE_CATEGORY", Splitter.SplitTextByDelimiter("_", QuoteStyle.Csv), {"CASE_CATEGORY", "CASE_SUB_CATEGORY"}),
    #"Inserted LOV" = Table.AddColumn(#"Split Column by Delimiter", "LOV", each Text.Combine({[CASE_TYPE], [CASE_AREA],  [CASE_SUB_AREA], [CASE_CATEGORY], [CASE_SUB_CATEGORY]}, " - "), type text),
    #"Added Type0" = Table.AddColumn(#"Inserted LOV", "Type0", each if List.Contains({"Assurance", "App Assistance", "Network"}, [CASE_TYPE]) then "Tech" else "Non-Tech", type text),
    #"Added Clean Type" = Table.AddColumn(#"Added Type0", "Clean Case Type", each if [CASE_TYPE] = "Assurance" or [CASE_TYPE] = "Touch Point" or [CASE_TYPE] = "Billing" then [CASE_TYPE] else "Others"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Clean Type",{{"CASE_CREATED_ON - Year", Int64.Type}, {"CASE_CREATED_ON - Month", type text}, {"CASE_CREATED_ON - Day", Int64.Type}, {"ACCOUNT_NO", Int64.Type}, {"CASE_ID", Int64.Type}, {"CASE_TITLE", type text}, {"CREATED_BY", type text}, {"CREATOR_BUSINESS_UNIT", type text}, {"CASE_AREA", type text}, {"CASE_TYPE", type text}, {"CASE_CATEGORY", type text}, {"CASE_SUB_AREA", type text}, {"SOURCE", type text}, {"CASE_STATUS", type text}, {"CASE_OWNER_STAFF", type text}, {"CASE_OWNER_BUSINESS_UNIT", type text}, {"BUSINESS_DAY_AGING", Int64.Type}, {"CASE_AGING_CAL_DAYS", Int64.Type}, {"BUSS AGING RANGE", type text}, {"Average of Index.2", Int64.Type}, {"Type0", type text}, {"Date_Creation", type date}}),
    Report_Time = List.Max(#"Changed Type1"[Date_Creation]),
    Add_Endtime = Table.AddColumn(#"Changed Type1", "EFFECTIVE_END_TIME", each 
        if [CASE_STATUS] <> "Closed"
        then Report_Time 
        else Date.AddDays([Date_Creation],[CASE_AGING_CAL_DAYS]), 
        type datetime
    ),
    Add_BD2 = Table.AddColumn(Add_Endtime , "BD2", each Duration.Days(BD_Calc([Date_Creation], [EFFECTIVE_END_TIME])), Int64.Type),
    #"Removed Columns" = Table.RemoveColumns(Add_BD2,{"EFFECTIVE_END_TIME"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"BUSINESS_DAY_AGING", "BUSINESS_DAY_AGING_OG"}, {"BD2", "BUSINESS_DAY_AGING"}}),
    // #"Adjust BD_AGING" = Table.ReplaceValue(
    //    #"Renamed Columns",
    //     each [BUSINESS_DAY_AGING],
    //     each if [CASE_STATUS] <> "Closed" then [BUSINESS_DAY_AGING] + 1 else [BUSINESS_DAY_AGING],
    //     Replacer.ReplaceValue,
    //     {"BUSINESS_DAY_AGING"}
    // ),
    #"Adjust CD_AGING" = Table.ReplaceValue(
        #"Renamed Columns",
        each [CASE_AGING_CAL_DAYS],
        each if [CASE_STATUS] = "Processing" then [CASE_AGING_CAL_DAYS] + 1 else [CASE_AGING_CAL_DAYS],
        Replacer.ReplaceValue,
        {"CASE_AGING_CAL_DAYS"}
    )
in
    #"Adjust CD_AGING"
