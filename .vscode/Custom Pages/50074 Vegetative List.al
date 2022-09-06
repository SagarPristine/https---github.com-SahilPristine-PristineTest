page 50074 "Vegetative Inspection II List"
{
    CardPageID = "Inspection Card";
    PageType = List;
    Caption = 'Vegetative Inspection';
    SourceTable = "Inspection Header";
    SourceTableView = SORTING("No.", Type)
                      WHERE(Type = CONST(Vegetative),
                            Posted = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {

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
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        //UserPermission
        //ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //UserPermission
        //ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin

    end;

    var

}

