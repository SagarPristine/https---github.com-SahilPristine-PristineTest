page 50081 "Inspection Card"
{
    Caption = 'Inspection Card';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Inspection Header";
    SourceTableView = WHERE(Posted = FILTER(false));
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            group(General)
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
            part(InspectionLines1; 50077)
            {
                ApplicationArea = ALL;
                SubPageLink = "Document No." = FIELD("No."),
                              Type = FIELD("Type");
                UpdatePropagation = Both;
                Visible = ViewInspection1;
            }
            part(InspectionLines2; 50078)
            {
                ApplicationArea = ALL;
                SubPageLink = "Document No." = FIELD("No."),
                              Type = FIELD("TYPE");
                UpdatePropagation = Both;
                Visible = ViewInspection2;
            }
            part(InspectionLines3; 50079)
            {
                ApplicationArea = ALL;
                SubPageLink = "Document No." = FIELD("No."),
                              Type = FIELD("Type");
                UpdatePropagation = Both;
                Visible = ViewInspection3;
            }
            part(InspectionLines4; 50080)
            {
                ApplicationArea = ALL;
                SubPageLink = "Document No." = FIELD("No."),
                              Type = FIELD("Type");
                UpdatePropagation = Both;
                Visible = ViewInspection4;
            }

        }
    }

    actions
    {
        area(processing)
        {
            group("&Posting")
            {
                Caption = '&Posting';
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        InspectionLine: Record "Inspection Line";
                    begin
                        // Rec.TESTFIELD("Season Code");
                        // //Rec.TESTFIELD("Date of Planting List"); LK
                        // Rec.TESTFIELD("Date of Inspection");
                        // Rec.TESTFIELD("Crop Code");
                        // Rec.TESTFIELD("Arrival Plan No.");
                        // Rec.TESTFIELD("Organizer No.");

                        // IF Rec.Type = Rec.Type::Flowering THEN BEGIN
                        //     InspectionLine.RESET;
                        //     InspectionLine.SETCURRENTKEY(Type, "Document No.", "Line No.");
                        //     InspectionLine.SETRANGE(Type, Rec.Type);
                        //     InspectionLine.SETRANGE("Document No.", Rec."No.");
                        //     IF InspectionLine.FINDSET THEN BEGIN
                        //         REPEAT
                        //             IF NOT ((InspectionLine."Actual Area" + InspectionLine."Rejection/PLD Area") <= InspectionLine."Given Area") THEN
                        //                 ERROR('Sum of Actual & Rejection/Pld area should be less than or equal to Given Area of Production Lot No. %1.', InspectionLine."Production Lot No.");
                        //         UNTIL InspectionLine.NEXT = 0;
                        //     END;
                        // END;

                        // PostInspectionReport;
                        // CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FieldVisibilities;
    end;

    trigger OnDeleteRecord(): Boolean
    begin


    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //UserPermission
        CASE Rec.Type OF
            Rec.Type::Nursery:
                BEGIN
                    CanView := FALSE;
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE(inspection, TRUE);
                    IF recUL.FINDFIRST THEN
                        CanInsert := TRUE
                    ELSE
                        CanInsert := FALSE;
                END;
            Rec.Type::Vegetative:
                BEGIN
                    CanView := FALSE;
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE(inspection, TRUE);
                    IF recUL.FINDFIRST THEN
                        CanInsert := TRUE
                    ELSE
                        CanInsert := FALSE;
                END;
            Rec.Type::Isolation:
                BEGIN
                    CanView := FALSE;
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE(inspection, TRUE);
                    IF recUL.FINDFIRST THEN
                        CanInsert := TRUE
                    ELSE
                        CanInsert := FALSE;
                END;
            Rec.Type::"Pre Flowering Roughing":
                BEGIN
                    CanView := FALSE;
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE(inspection, TRUE);
                    IF recUL.FINDFIRST THEN
                        CanInsert := TRUE
                    ELSE
                        CanInsert := FALSE;
                END;
            Rec.Type::"Flowering Roughing":
                BEGIN
                    CanView := FALSE;
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE(inspection, TRUE);
                    IF recUL.FINDFIRST THEN
                        CanInsert := TRUE
                    ELSE
                        CanInsert := FALSE;
                END;
        END;
    end;

    var
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        recUL: Record "User location";
        CanView: Boolean;
        CanInsert: Boolean;
        ViewInspection1: Boolean;
        ViewInspection2: Boolean;
        ViewInspection3: Boolean;
        ViewInspection4: Boolean;
        ViewInspection5: Boolean;
        PL: Record "Planting List Line";
        ISL: Record "Inspection Line";
        ISH: Record "Inspection Header";

    // procedure PostInspectionReport()
    // var
    //     Con_G_001: Label 'Do you want to Post Inspection Report ?';
    //     recInspectionLine: Record "Inspection Line";
    // begin
    //     recInspectionLine.RESET;
    //     recInspectionLine.SETRANGE("Document No.");
    //     recInspectionLine.SETRANGE("Document No.", Rec."No.");
    //     IF recInspectionLine.FINDSET THEN BEGIN
    //         REPEAT
    //             recInspectionLine.TESTFIELD("Production Lot No.");
    //             recInspectionLine.TESTFIELD("Item No.");
    //         UNTIL recInspectionLine.NEXT = 0;
    //     END;

    //     IF NOT CONFIRM(Con_G_001, FALSE) THEN
    //         EXIT
    //     ELSE BEGIN
    //         TESTFIELD("No.");
    //         TESTFIELD("Season Code");
    //         TESTFIELD(Type);
    //         TESTFIELD(Posted, FALSE);
    //         Rec.Posted := TRUE;
    //         MODIFY;
    //         recInspectionLine.RESET;
    //         recInspectionLine.SETRANGE("Document No.");
    //         recInspectionLine.SETRANGE("Document No.", Rec."No.");
    //         IF recInspectionLine.FINDSET THEN BEGIN
    //             REPEAT
    //                 recInspectionLine.Posted := TRUE;
    //                 recInspectionLine.MODIFY;

    //                 ISH.RESET;
    //                 ISH.SETRANGE("Production Lot No.", recInspectionLine."Production Lot No.");
    //                 ISH.SETFILTER("Document Status", '<>%1', ISH."Document Status"::Inspected);
    //                 IF ISH.FINDFIRST THEN BEGIN
    //                     //PBS-SAG
    //                     PL.RESET;
    //                     PL.SETCURRENTKEY("Production Lot No.");
    //                     PL.SETRANGE("Production Lot No.", recInspectionLine."Production Lot No.");
    //                     IF PL.FINDFIRST THEN BEGIN
    //                         IF Type = Type::Nursery THEN BEGIN
    //                             PL."Inspection I Status" := PL."Inspection I Status"::Inspected;
    //                             IF PL.Vegetative = TRUE THEN
    //                                 PL."Inspection II Status" := PL."Inspection II Status"::Scheduled;
    //                             IF PL.Isolation = TRUE THEN
    //                                 PL."Inspection III Status" := PL."Inspection III Status"::Scheduled;
    //                             IF PL."Pre Flowering" = TRUE THEN
    //                                 PL."Inspection IV Status" := PL."Inspection IV Status"::Scheduled;
    //                             PL.MODIFY;
    //                         END;
    //                         IF Type = Type::Vegetative THEN
    //                             PL."Inspection II Status" := PL."Inspection II Status"::Inspected;
    //                         IF Type = Type::Isolation THEN
    //                             PL."Inspection III Status" := PL."Inspection III Status"::Inspected;
    //                         IF Type = Type::"Pre Flowering" THEN
    //                             PL."Inspection IV Status" := PL."Inspection IV Status"::Inspected;
    //                         PL.MODIFY;

    //                         ISL.RESET;
    //                         ISL.SETCURRENTKEY("Production Lot No.");
    //                         ISL.SETRANGE("Production Lot No.", recInspectionLine."Production Lot No.");
    //                         IF ISL.FINDFIRST THEN BEGIN
    //                             ISH.RESET;
    //                             ISH.GET(ISL."Schedule No.");
    //                             IF Type = Type::Nursery THEN BEGIN
    //                                 ISL."Inspection I Status" := ISL."Inspection I Status"::Inspected;
    //                                 IF ISL.Vegetative = TRUE THEN
    //                                     ISL."Inspection II Status" := ISL."Inspection II Status"::Scheduled;
    //                                 IF ISL.Isolation = TRUE THEN
    //                                     ISL."Inspection III Status" := ISL."Inspection III Status"::Scheduled;
    //                                 IF ISL."Pre Flowering" = TRUE THEN
    //                                     ISL."Inspection IV Status" := ISL."Inspection IV Status"::Scheduled;
    //                                 ISL.MODIFY;
    //                             END;
    //                             IF Type = Type::Vegetative THEN
    //                                 ISL."Inspection II Status" := ISL."Inspection II Status"::Inspected;
    //                             IF Type = Type::Isolation THEN
    //                                 ISL."Inspection III Status" := ISL."Inspection III Status"::Inspected;
    //                             IF Type = Type::"Pre Flowering" THEN
    //                                 ISL."Inspection IV Status" := ISL."Inspection IV Status"::Inspected;
    //                             ISL.MODIFY;
    //                         END;

    //                     END;
    //                 END;
    //             //PBS-SAG
    //             UNTIL recInspectionLine.NEXT = 0;
    //         END;
    //         //for Updating Planting List
    //         UpdatePlantingListTable;
    //     END;
    // end;

    // local procedure UpdatePlantingListTable()
    // var
    //     recPlantingList: Record "50017";
    //     recPlantingListLine: Record "50018";
    //     recInspectionLine: Record "50021";
    //     InspectionOne: Boolean;
    //     InspectionTwo: Boolean;
    //     InspectionThree: Boolean;
    //     InspectionFour: Boolean;
    //     InspectionFive: Boolean;
    // begin
    //     IF Rec."Arrival Plan No." <> '' THEN BEGIN
    //         recInspectionLine.RESET;
    //         recInspectionLine.SETCURRENTKEY("Document No.", Type, "Line No.");
    //         recInspectionLine.SETRANGE("Document No.", Rec."No.");
    //         recInspectionLine.SETRANGE(Type, Rec.Type);
    //         IF recInspectionLine.FINDSET THEN BEGIN
    //             REPEAT
    //                 recPlantingListLine.RESET;
    //                 recPlantingListLine.SETCURRENTKEY("Document No.", "Production Lot No.", "Item No.", "Line No.");
    //                 recPlantingListLine.SETRANGE("Document No.", Rec."Arrival Plan No.");
    //                 recPlantingListLine.SETRANGE("Production Lot No.", recInspectionLine."Production Lot No.");
    //                 recPlantingListLine.SETRANGE("Variety Code", recInspectionLine."Variety No.");
    //                 IF recPlantingListLine.FINDFIRST THEN BEGIN
    //                     IF Rec.Type = Rec.Type::Nursery THEN
    //                         recPlantingListLine.Nursery := TRUE
    //                     ELSE
    //                         IF Rec.Type = Rec.Type::Vegetative THEN
    //                             recPlantingListLine.Vegetative := TRUE
    //                         ELSE
    //                             IF Rec.Type = Rec.Type::Isolation THEN
    //                                 recPlantingListLine.Isolation := TRUE
    //                             ELSE
    //                                 IF Rec.Type = Rec.Type::"Pre Flowering" THEN
    //                                     recPlantingListLine."Pre Flowering" := TRUE
    //                                 ELSE
    //                                     IF Rec.Type = Rec.Type::Flowering THEN
    //                                         recPlantingListLine.Flowering := TRUE;
    //                     recPlantingListLine.MODIFY;
    //                 END;
    //             UNTIL recInspectionLine.NEXT = 0;
    //         END;

    //         InspectionOne := TRUE;
    //         InspectionTwo := TRUE;
    //         InspectionThree := TRUE;
    //         InspectionFour := TRUE;
    //         InspectionFive := TRUE;
    //         recPlantingListLine.RESET;
    //         recPlantingListLine.SETCURRENTKEY("Document No.", "Line No.");
    //         recPlantingListLine.SETRANGE("Document No.", Rec."Arrival Plan No.");
    //         IF recPlantingListLine.FINDSET THEN BEGIN
    //             REPEAT
    //                 IF Rec.Type = Rec.Type::Nursery THEN BEGIN
    //                     IF recPlantingListLine.Nursery <> TRUE THEN
    //                         InspectionOne := FALSE;
    //                 END ELSE
    //                     IF Rec.Type = Rec.Type::Vegetative THEN BEGIN
    //                         IF recPlantingListLine.Vegetative <> TRUE THEN
    //                             InspectionTwo := FALSE
    //                     END ELSE
    //                         IF Rec.Type = Rec.Type::Isolation THEN BEGIN
    //                             IF recPlantingListLine.Isolation <> TRUE THEN
    //                                 InspectionThree := FALSE
    //                         END ELSE
    //                             IF Rec.Type = Rec.Type::"Pre Flowering" THEN BEGIN
    //                                 IF recPlantingListLine."Pre Flowering" <> TRUE THEN
    //                                     InspectionFour := FALSE;
    //                             END ELSE
    //                                 IF Rec.Type = Rec.Type::Flowering THEN BEGIN
    //                                     IF recPlantingListLine.Flowering <> TRUE THEN
    //                                         InspectionFive := FALSE;
    //                                 END;
    //                 recPlantingListLine.MODIFY;
    //             UNTIL recPlantingListLine.NEXT = 0;
    //         END;

    //         recPlantingList.RESET;
    //         recPlantingList.GET(Rec."Arrival Plan No.");
    //         IF Rec.Type = Rec.Type::Nursery THEN BEGIN
    //             IF InspectionOne = TRUE THEN
    //                 recPlantingList.Nursery := TRUE;
    //         END ELSE
    //             IF Rec.Type = Rec.Type::Vegetative THEN BEGIN
    //                 IF InspectionTwo = TRUE THEN
    //                     recPlantingList.Vegetative := TRUE;
    //             END ELSE
    //                 IF Rec.Type = Rec.Type::Isolation THEN BEGIN
    //                     IF InspectionThree = TRUE THEN
    //                         recPlantingList.Isolation := TRUE;
    //                 END ELSE
    //                     IF Rec.Type = Rec.Type::"Pre Flowering" THEN BEGIN
    //                         IF InspectionFour = TRUE THEN
    //                             recPlantingList."Pre Flowering" := TRUE;
    //                     END ELSE
    //                         IF Rec.Type = Rec.Type::Flowering THEN BEGIN
    //                             IF InspectionFive = TRUE THEN
    //                                 recPlantingList.Flowering := TRUE;
    //                         END;
    //         recPlantingList.MODIFY;
    //     END;
    // end;

    local procedure CheckInspectionType()
    begin
        //UserPermission
        //Check already exist or not
        // CASE Rec.Type OF
        //     Rec.Type::Nursery:
        //         BEGIN
        //             CanView := FALSE;
        //             ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        //             ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDULW(CanView, CanInsert, Var_Locations, 13);
        //             FILTERGROUP(10);
        //             SETFILTER("Production Centre", Var_Locations, '');
        //             FILTERGROUP(0);
        //         END;
        //     Rec.Type::Vegetative:
        //         BEGIN
        //             CanView := FALSE;
        //             ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        //             ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDULW(CanView, CanInsert, Var_Locations, 15);
        //             FILTERGROUP(10);
        //             SETFILTER("Production Centre", Var_Locations, '');
        //             FILTERGROUP(0);
        //         END;
        //     Rec.Type::Isolation:
        //         BEGIN
        //             CanView := FALSE;
        //             ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        //             ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDULW(CanView, CanInsert, Var_Locations, 17);
        //             FILTERGROUP(10);
        //             SETFILTER("Production Centre", Var_Locations, '');
        //             FILTERGROUP(0);
        //         END;
        //     Rec.Type::"Pre Flowering":
        //         BEGIN
        //             CanView := FALSE;
        //             ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        //             ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDULW(CanView, CanInsert, Var_Locations, 19);
        //             FILTERGROUP(10);
        //             SETFILTER("Production Centre", Var_Locations, '');
        //             FILTERGROUP(0);
        //         END;
        //     Rec.Type::Flowering:
        //         BEGIN
        //             CanView := FALSE;
        //             CanInsert := FALSE;
        //             ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        //             ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDULW(CanView, CanInsert, Var_Locations, 21);
        //             FILTERGROUP(10);
        //             SETFILTER("Production Centre", Var_Locations, '');
        //             FILTERGROUP(0);
        //         END;
        //END;
    end;

    local procedure FieldVisibilities()
    begin
        ViewInspection1 := FALSE;
        ViewInspection2 := FALSE;
        ViewInspection3 := FALSE;
        ViewInspection4 := FALSE;
        ViewInspection5 := FALSE;

        CASE Rec.Type OF
            Rec.Type::Nursery:
                BEGIN
                    ViewInspection1 := TRUE;
                END;
            Rec.Type::Vegetative:
                BEGIN
                    ViewInspection2 := TRUE;
                END;
            Rec.Type::Isolation:
                BEGIN
                    ViewInspection3 := TRUE;
                END;
            Rec.Type::"Pre Flowering Roughing":
                BEGIN
                    ViewInspection4 := TRUE;
                END;
            Rec.Type::"Flowering Roughing":
                BEGIN
                    ViewInspection5 := TRUE;
                END;
        END;
    end;
}

