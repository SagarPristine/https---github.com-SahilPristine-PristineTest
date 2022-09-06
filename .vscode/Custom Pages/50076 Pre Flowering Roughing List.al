page 50076 "Pre Flowering Roughing List"
{
    CardPageID = "Inspection Card";
    Caption = 'Pre Flowering Roughing List';
    PageType = List;
    SourceTable = "Inspection Header";
    SourceTableView = SORTING("No.", Type)
                      WHERE(Type = CONST("Pre Flowering Roughing"),
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
        //UserPermission
        // Rec.Type := Rec.Type::"Inspection IV";//LK
        // recUL.RESET;
        // recUL.SETCURRENTKEY("User ID");
        // recUL.SETRANGE("User ID", USERID);
        // recUL.SETRANGE("Inspection IV", TRUE);
        // IF recUL.FINDFIRST THEN
        //     CanInsert := TRUE
        // ELSE
        //     CanInsert := FALSE;
        // ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnOpenPage()
    begin
        // //UserPermission
        // //Check already exist or not
        // CanView := FALSE;
        // ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        // ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDULW(CanView, CanInsert, Var_Locations, 19);
        // FILTERGROUP(10);
        // SETFILTER("Production Centre", Var_Locations, '');
        // FILTERGROUP(0);
        // IF CanView = FALSE THEN
        //     ERROR(ContactAdminText003)
        // ELSE BEGIN
        //     IF CanInsert <> TRUE THEN
        //         CurrPage.EDITABLE(FALSE);
        // END;
    end;

    var
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        recUL: Record 50015;
        CanView: Boolean;
        CanInsert: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
}

