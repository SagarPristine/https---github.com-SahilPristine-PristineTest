#pragma warning disable
page 50049 "Process Transfer List"
{
    CardPageID = 50047;
    PageType = List;
    SourceTable = "Process Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = all;
                }
                field("Item Product Group Code"; "Item Product Group Code")
                {
                    ApplicationArea = all;
                }
                field("Class of Seeds"; "Class of Seeds")
                {
                    ApplicationArea = all;
                }
                field("From Stage"; "From Stage")
                {
                    ApplicationArea = all;
                }
                field("To Stage"; "To Stage")
                {
                    ApplicationArea = all;
                }
                field(Location; Location)
                {
                    ApplicationArea = all;
                }
                field(Season; Season)
                {
                    ApplicationArea = all;
                }
                field(Shift; Shift)
                {
                    ApplicationArea = all;
                }
                field("Starting DateTime"; "Starting DateTime")
                {
                    ApplicationArea = all;
                }
                field("Ending DateTime"; "Ending DateTime")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Pending Process list Report")
            {
                Image = "report";

                trigger OnAction()
                begin
                    RecILE.RESET;
                    RecILE.SETFILTER("Variant Code", '%1', 'CLEANING');
                    IF RecILE.FINDSET THEN
                        REPORT.RUNMODAL(50018, TRUE, FALSE, RecILE);

                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //UserPermission
        recUL.RESET;
        recUL.SETCURRENTKEY("User ID");
        recUL.SETRANGE("User ID", USERID);
        recUL.SETRANGE("Process Header", TRUE);
        IF recUL.FINDFIRST THEN
            CanInsert := TRUE
        ELSE
            CanInsert := FALSE;
        //ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnOpenPage()
    begin
        //UserPermission
        //Check already exist or not
        // CanView := FALSE;
        // ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        // ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDULW(CanView, CanInsert, Var_Locations, 1);
        // FILTERGROUP(10);
        // SETFILTER(Location, Var_Locations, '');
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
        recUL: Record "User Location";
        CanView: Boolean;
        CanInsert: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
        RecILE: Record 32;
}

