page 50065 "Pollination List"
{
    CardPageID = "Inspection Card";
    PageType = List;
    Caption = 'Pollination';
    SourceTable = "Inspection Header";
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTableView = SORTING("No.", Type)
                      WHERE(Type = CONST(Pollination),
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
        area(reporting)
        {
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin


    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnOpenPage()
    begin

    end;

    var
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        recUL: Record "User Location";
        CanView: Boolean;
        CanInsert: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
}

