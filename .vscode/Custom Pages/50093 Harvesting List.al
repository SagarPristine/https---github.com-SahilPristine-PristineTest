page 50093 "Harvesting Insp. VIII List"
{
    CardPageID = "Inspection Card";
    PageType = List;
    Caption = 'Harvesting';
    SourceTable = "Inspection Header";
    SourceTableView = SORTING("No.", Type)
                      WHERE(Type = CONST(Harvesting),
                            Posted = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Production Centre"; Rec."Production Centre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Centre field.';
                }
                field("Date of Inspection"; Rec."Date of Inspection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Inspection field.';
                }
                field("Production Lot No."; Rec."Production Lot No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Lot No. field.';
                }
            }
        }
    }

    actions
    {
    }

    var

}

