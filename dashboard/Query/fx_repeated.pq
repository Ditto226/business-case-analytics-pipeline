= (
    sourceTable as table,
    groupKeys as list,
    dateColumn as text,
    optional windowDays as number,
    optional outputColumn as text
) as table =>
let
    days = if windowDays = null then 30 else windowDays,
    // colName = if outputColumn = null then "Repeats_Within_" & Text.From(days) & "D" else outputColumn,
    colName = if outputColumn = null then "Repeated" & Text.From(groupKeys{1}) else outputColumn,

    Grouped = Table.Group(
        sourceTable,
        groupKeys,
        {
            {"SubTable", each 
                let
                    sorted = Table.Sort(_, {"CASE_ID", Order.Ascending} ),
                    addIdx = Table.AddIndexColumn(sorted, "RowIdx", 0, 1, Int64.Type),
                    datesList = List.Buffer(Table.Column(addIdx, dateColumn)),
                    
                    addCount = Table.AddColumn(
                        addIdx,
                        colName,
                        each 
                            let
                                // Check if any grouping key in the current row is null or empty/blank
                                keyValues = Record.ToList(Record.SelectFields(_, groupKeys)),
                                hasInvalidKey = List.AnyTrue(
                                    List.Transform(
                                        keyValues, 
                                        (k) => k = null or (k is text and Text.Trim(k) = "")
                                    )
                                )
                            in
                                // 1. If key is missing/null, bypass calculation and output 0
                                if hasInvalidKey then 0

                                // 2. First valid row in partition has 0 prior repeats
                                else if [RowIdx] = 0 then 0

                                // 3. Normal rolling window count for valid keys
                                else 
                                    let
                                        currentDate = Record.Field(_, dateColumn),
                                        // Take preceding dates and reverse so most recent is first
                                        priorDatesRecentFirst = List.Reverse(List.FirstN(datesList, [RowIdx])),
                                        // It stops as soon as it encounters a date outside the window
                                        inWindow = List.FirstN(
                                            priorDatesRecentFirst, 
                                            each _ <> null and Duration.Days(currentDate - _) <= days
                                        )
                                    in
                                        List.Count(inWindow),
                        Int64.Type
                    ),
                    cleaned = Table.RemoveColumns(addCount, {"RowIdx"})
                in
                    cleaned,
                type table
            }
        },
        GroupKind.Local
    ),
    Expanded = Table.Combine(Grouped[SubTable])
in
    Expanded