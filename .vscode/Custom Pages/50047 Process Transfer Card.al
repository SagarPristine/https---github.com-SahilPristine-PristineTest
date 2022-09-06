#pragma warning disable
page 50047 "Process Transfer Card"
{
    PageType = Document;
    UsageCategory = None;
    RefreshOnActivate = true;
    SourceTable = "Process Header";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Location; Location)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                    end;
                }
                field("Location Name"; "Location Name")
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
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Trec50008: Record "Process Line";
                    begin

                        //When Crop Code is Blank
                        IF Rec."Crop Code" = '' THEN BEGIN
                            Rec."Item No." := '';
                            //Rec."From Stage"  := '';
                            //Rec."To Stage"    := '';
                            Rec.Location := '';
                            //Rec.Season := '';
                            //lookupItem := FALSE;
                            Trec50008.RESET;
                            Trec50008.SETCURRENTKEY("Document No.");
                            Trec50008.SETRANGE("Document No.", Rec."No.");
                            IF Trec50008.FINDSET THEN
                                Trec50008.DELETEALL;
                        END;
                        // ItemLookup;
                        CurrPage.UPDATE;
                    end;
                }
                field(Season; Season)
                {
                    ApplicationArea = all;
                    LookupPageID = "Season Master";
                }
                field("From Stage"; "From Stage")
                {
                    ApplicationArea = all;
                    Editable = true;
                    LookupPageID = "Crop Stage Master List";
                    TableRelation = "Crop Stage Master".Stage WHERE("Crop Code" = FIELD("Crop Code"));

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("To Stage"; "To Stage")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group("Item Details")
            {
                Editable = ReleaseReopenDoc;
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                    LookupPageID = "Item List";
                    ShowMandatory = true;
                    TableRelation = Item."No." WHERE("Crop Code" = FIELD("Crop Code"));

                    trigger OnValidate()
                    var
                        Trec50008: Record "Process Line";
                        InvtrySetup: Record 313;
                    begin
                        //When Item No. is Blank
                        IF Rec."Item No." = '' THEN BEGIN
                            Rec.Location := '';
                            Trec50008.RESET;
                            Trec50008.SETCURRENTKEY("Document No.");
                            Trec50008.SETRANGE("Document No.", Rec."No.");
                            IF Trec50008.FINDSET THEN
                                Trec50008.DELETEALL;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = all;
                }
                field("Class of Seeds"; "Class of Seeds")
                {
                    ApplicationArea = all;
                }
                // field("Item Product Group Code"; "Item Product Group Code")
                // {
                // }
            }
            group(Contractor1)
            {
                Visible = false;
                Caption = 'Contractor';
                field(Contractor; Contractor)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Contractor Name"; "Contractor Name")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Supervisor Name"; "Supervisor Name")
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
            part("Process Line"; 50048)
            {
                ApplicationArea = all;
                Caption = 'Process Line';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            part("Consumption Lines"; 50051)
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        recProcessHeader: Record "Process Header";
                        recProcessLine: Record "Process Line";
                        ProcessInvoiceHeader: Record "Process Invoice Header";
                    begin
                        //Comment by Sagar
                        /*
                                                IF Rec."To Stage" = 'PACKED' THEN BEGIN
                                                    rec27.RESET;
                                                    IF rec27.GET(Rec."Item No.") THEN BEGIN
                                                        IF (rec27."Class of Seeds" = rec27."Class of Seeds"::Foundation) OR (rec27."Class of Seeds" = rec27."Class of Seeds"::TL) THEN BEGIN
                                                            recProcessLine.RESET;
                                                            recProcessLine.SETCURRENTKEY("Document No.");
                                                            recProcessLine.SETRANGE("Document No.", Rec."No.");
                                                            IF recProcessLine.FINDSET THEN BEGIN
                                                                REPEAT
                                                                    recProcessLine.TESTFIELD("Marketing Lot No.");
                                                                    recProcessLine.TESTFIELD("Packed Item Code");
                                                                    recProcessLine.TESTFIELD("Packing By");
                                                                    IF rec27."Class of Seeds" = rec27."Class of Seeds"::TL THEN BEGIN
                                                                        recProcessLine.TESTFIELD("Quality Test Date");
                                                                        recProcessLine.TESTFIELD("Expiry Date");
                                                                    END;
                                                                UNTIL recProcessLine.NEXT = 0;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                        */

                        Rec.TESTFIELD(Season);
                        IF Rec.Status = Rec.Status::Open THEN
                            CODEUNIT.RUN(CODEUNIT::"ProcessTransfer-Post (Yes/No)", Rec);
                        IF Rec.Status = Rec.Status::Complete THEN
                            ReleaseReopenDoc := FALSE;
                        CurrPage.UPDATE;
                        COMMIT;

                        //For Delete Process Transfer After post
                        IF Rec.Status = Rec.Status::Complete THEN BEGIN
                            recProcessLine.RESET;
                            recProcessLine.SETCURRENTKEY("Document No.");
                            recProcessLine.SETRANGE("Document No.", Rec."No.");
                            IF recProcessLine.FINDSET THEN
                                recProcessLine.DELETEALL;
                            IF recProcessHeader.GET(Rec."No.") THEN
                                recProcessHeader.DELETE;
                        END;


                        //Comment By Sagar
                        /*
                                                IF Rec."To Stage" = 'PACKED' THEN BEGIN
                                                    rec27.RESET;
                                                    IF rec27.GET(Rec."Item No.") THEN BEGIN
                                                        IF (rec27."Class of Seeds" = rec27."Class of Seeds"::TL) THEN BEGIN
                                                            //Running Release Order, Statement 1, Statement 2
                                                            ProcessInvoiceHeader.RESET;
                                                            ProcessInvoiceHeader.SETCURRENTKEY("Process Transfer Pre No.");
                                                            ProcessInvoiceHeader.SETRANGE("Process Transfer Pre No.", Rec."No.");
                                                            IF ProcessInvoiceHeader.FINDFIRST THEN BEGIN
                                                                REPORT.RUNMODAL(50017, TRUE, FALSE, ProcessInvoiceHeader); //Release Order
                                                                REPORT.RUNMODAL(50036, TRUE, FALSE, ProcessInvoiceHeader); //Statement 1
                                                                REPORT.RUNMODAL(50037, TRUE, FALSE, ProcessInvoiceHeader); //Statement 2
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                                */
                    end;
                }
                action(CalCulateConsumption)
                {
                    Caption = 'Calculate Consumption';
                    Ellipsis = true;
                    Image = CalculateConsumption;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                    begin
                        CalculateBom(Rec);
                        CurrPage.Update();
                    end;
                }
            }
            group(Process)
            {
                Caption = 'Process';
                Image = Post;
                action("Create Marketing Lot No.")
                {
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        //recLotRangeMaster: Record "50019";
                        recProcessLine: Record "Process Line";
                    //rec50019: Record "50019";
                    begin
                        /*
                          recProcessLine.RESET;
                          recProcessLine.SETCURRENTKEY("Document No.", "Line No.");
                          recProcessLine.SETRANGE("Document No.", Rec."No.");
                          IF recProcessLine.FINDSET THEN BEGIN
                              REPEAT
                                  IF (recProcessLine."Packed Item Code" <> '') AND (recProcessLine.RVD = FALSE) THEN BEGIN
                                      recProcessLine.CALCFIELDS("Location Code");

                                      //for "Marketing Lot No" & "Date of Test"
                                      rec27.RESET;
                                      IF rec27.GET(recProcessLine."Item No.") THEN BEGIN
                                          IF rec27."Class of Seeds" = rec27."Class of Seeds"::Breeder THEN BEGIN //for Breeder
                                                                                                                 //for "Marketing Lot No"
                                              recLotRangeMaster.RESET;
                                              recLotRangeMaster.SETCURRENTKEY("Production Location", Season, Item, Type, Blocked);
                                              recLotRangeMaster.SETRANGE("Production Location", recProcessLine."Location Code");
                                              recLotRangeMaster.SETRANGE(Season, Rec.Season);
                                              recLotRangeMaster.SETRANGE(Item, '');
                                              recLotRangeMaster.SETRANGE(Type, recLotRangeMaster.Type::"Marketing Lot No.");
                                              recLotRangeMaster.SETRANGE(Blocked, FALSE);
                                              IF recLotRangeMaster.FINDFIRST THEN BEGIN
                                                  IF recLotRangeMaster."Next Available Lot" = '' THEN
                                                      ERROR('Please Create Lot Range Series for it. It looked like you havenot created yet.');
                                                  recProcessLine.VALIDATE("Marketing Lot No.", recLotRangeMaster."Next Available Lot");
                                                  recLotRangeMaster."Last No. Used" := recProcessLine."Marketing Lot No.";
                                                  recLotRangeMaster."Next Available Lot" := INCSTR(recProcessLine."Marketing Lot No.");
                                                  recLotRangeMaster.MODIFY;
                                              END ELSE
                                                  ERROR('Lot Range for Location %1, Season %2, Item "" with Type Marketing Lot No. doesnot exist.', Rec.Location, Rec.Season);
                                          END ELSE
                                              IF rec27."Class of Seeds" = rec27."Class of Seeds"::Foundation THEN BEGIN //for Foundation
                                                                                                                        //for "Marketing Lot No"
                                                  recLotRangeMaster.RESET;
                                                  recLotRangeMaster.SETCURRENTKEY("Production Location", Season, Item, Type, Blocked);
                                                  recLotRangeMaster.SETRANGE("Production Location", recProcessLine."Location Code");
                                                  recLotRangeMaster.SETRANGE(Season, Rec.Season);
                                                  recLotRangeMaster.SETRANGE(Item, recProcessLine."Packed Item Code");
                                                  recLotRangeMaster.SETRANGE(Type, recLotRangeMaster.Type::"Marketing Lot No.");
                                                  recLotRangeMaster.SETRANGE(Blocked, FALSE);
                                                  IF recLotRangeMaster.FINDFIRST THEN BEGIN
                                                      IF recLotRangeMaster."Next Available Lot" = '' THEN
                                                          ERROR('Please Create Lot Range Series for it. It looked like you havenot created yet.');
                                                      recProcessLine.VALIDATE("Marketing Lot No.", recLotRangeMaster."Next Available Lot");
                                                      recLotRangeMaster."Last No. Used" := recProcessLine."Marketing Lot No.";
                                                      recLotRangeMaster."Next Available Lot" := INCSTR(recProcessLine."Marketing Lot No.");
                                                      recLotRangeMaster.MODIFY;
                                                  END ELSE
                                                      ERROR('Lot Range for Location %1, Season %2, Item %3 with Type Marketing Lot No. doesnot exist.', Rec.Location, Rec.Season, recProcessLine."Packed Item Code");
                                              END ELSE
                                                  IF rec27."Class of Seeds" = rec27."Class of Seeds"::TL THEN BEGIN //for Hybrid
                                                                                                                    //for "Marketing Lot No"
                                                      recLotRangeMaster.RESET;
                                                      recLotRangeMaster.SETCURRENTKEY("Production Location", Season, Item, Type, Blocked);
                                                      recLotRangeMaster.SETRANGE("Production Location", recProcessLine."Location Code");
                                                      recLotRangeMaster.SETRANGE(Season, Rec.Season);
                                                      recLotRangeMaster.SETRANGE(Item, recProcessLine."Packed Item Code");
                                                      recLotRangeMaster.SETRANGE(Type, recLotRangeMaster.Type::"Marketing Lot No.");
                                                      recLotRangeMaster.SETRANGE(Blocked, FALSE);
                                                      IF recLotRangeMaster.FINDFIRST THEN BEGIN
                                                          IF recLotRangeMaster."Next Available Lot" = '' THEN
                                                              ERROR('Please Create Lot Range Series for it. It looked like you havenot created yet.');
                                                          recProcessLine.VALIDATE("Marketing Lot No.", recLotRangeMaster."Next Available Lot");
                                                          recLotRangeMaster."Last No. Used" := recProcessLine."Marketing Lot No.";
                                                          recLotRangeMaster."Next Available Lot" := INCSTR(recProcessLine."Marketing Lot No.");
                                                          recLotRangeMaster.MODIFY;
                                                      END ELSE
                                                          ERROR('Lot Range for Location %1, Season %2, Item %3 with Type Marketing Lot No. doesnot exist.', Rec.Location, Rec.Season, recProcessLine."Packed Item Code");
                                                  END;
                                      END;
                                  END;
                              UNTIL recProcessLine.NEXT = 0;
                          END;
                                              */
                    end;


                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ItemLookup;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //UserPermission
        // ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //UserPermission
        //ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //UserPermission
        // recUL.RESET;
        // recUL.SETCURRENTKEY("User ID");
        // recUL.SETRANGE("User ID", USERID);
        // recUL.SETRANGE("Process Header", TRUE);
        // IF recUL.FINDFIRST THEN
        //     CanInsert := TRUE
        // ELSE
        //     CanInsert := FALSE;
        // ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);

        ItemLookup;
    end;

    trigger OnOpenPage()
    begin
        //UserPermission
        //Check already exist or not
        //CanView := FALSE;
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

        ItemLookup;
    end;

    var
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        lookupItem: Boolean;
        ReleaseReopenDoc: Boolean;
        RecComplete: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
        recUL: Record 50015;
        CanView: Boolean;
        CanInsert: Boolean;
        rec27: Record 27;
        FromStageR: Boolean;
        FromStageC: Boolean;
        FromStageGP: Boolean;
        InventorySetup: Record 313;

    local procedure ItemLookup()
    var
        rec27: Record 27;
        rec32: Record 32;
        CompanyInfo: Record 79;
    begin
        lookupItem := FALSE;
        IF Rec."Crop Code" <> '' THEN
            lookupItem := TRUE;

        //For Status
        IF Rec.Status = Rec.Status::Open THEN
            ReleaseReopenDoc := TRUE;
        IF Rec.Status = Rec.Status::Released THEN
            ReleaseReopenDoc := FALSE;
        IF Rec.Status = Rec.Status::Complete THEN
            ReleaseReopenDoc := FALSE;
    end;
}

