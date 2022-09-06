#pragma warning disable
page 50051 Consumption
{
    PageType = List;
    SourceTable = "Process Line";
    SourceTableView = WHERE("Entry Type" = FILTER(Consumption));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    TableRelation = Item."No." WHERE("Item Type" = FILTER("Non Seeds"));

                    trigger OnValidate()
                    begin
                        IF "Item No." <> '' THEN BEGIN
                            Item.GET("Item No.");
                            Description := Item.Description;
                            MODIFY;
                        END;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Consumed Qty"; "Total Avai. Qty.")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }

    var
        Item: Record 27;
}

