page 50101 "Posted Flowering Inspection V"
{
    CardPageID = "Inspection Card";
    PageType = List;
    Caption = 'Posted Flowering Inspection';
    SourceTable = "Inspection Header";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTableView = SORTING("No.", Type)
                      WHERE(Type = CONST("Flowering Roughing"),
                            Posted = FILTER(true));

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

