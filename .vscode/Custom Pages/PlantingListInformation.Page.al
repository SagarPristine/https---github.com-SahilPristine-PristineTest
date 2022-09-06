// page 50197 "Planting List Information"
// {
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     MultipleNewLines = true;
//     PageType = List;
//     PopulateAllFields = true;
//     SaveValues = false;
//     SourceTable = Table50018;
//     SourceTableView = SORTING (Document No., Line No.)
//                       ORDER(Ascending)
//                       WHERE (Posted = FILTER (No));

//     layout
//     {
//         area(content)
//         {
//             repeater()
//             {
//                 field("Document No."; "Document No.")
//                 {
//                 }
//                 field("FSIO No."; "FSIO No.")
//                 {
//                     Editable = false;
//                     LookupPageID = "Posted Sales Shipments";

//                     trigger OnValidate()
//                     begin
//                         EditableCropTypeHyrbid := FALSE;
//                         EditableCropTypeImproved := FALSE;
//                         Rec.CALCFIELDS("Item Crop Type");
//                         IF Rec."Item Crop Type" = Rec."Item Crop Type"::Hybrid THEN
//                             EditableCropTypeHyrbid := TRUE;
//                         IF Rec."Item Crop Type" = Rec."Item Crop Type"::Improved THEN
//                             EditableCropTypeImproved := TRUE;
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Organizer Code"; "Organizer Code")
//                 {
//                     Caption = 'Organiser/Co-ordinator Code';
//                 }
//                 field("Organizer Name"; "Organizer Name")
//                 {
//                     Caption = 'Organiser/Co-ordinator Name';
//                 }
//                 field("Zone Name"; "Zone Name")
//                 {
//                 }
//                 field("State Name"; "State Name")
//                 {
//                 }
//                 field("District Name"; "District Name")
//                 {
//                 }
//                 field("Region Name"; "Region Name")
//                 {
//                 }
//                 field("Taluka Name"; "Taluka Name")
//                 {
//                 }
//                 field("Grower Owner"; "Grower Owner")
//                 {
//                     Editable = false;
//                     LookupPageID = "Grower List";
//                 }
//                 field("Grower/Land Owner Name"; "Grower/Land Owner Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Crop Code"; "Crop Code")
//                 {
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Variety Code"; "Variety Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Item Product Group Code"; "Item Product Group Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Item Class of Seeds"; "Item Class of Seeds")
//                 {
//                     Editable = false;
//                 }
//                 field("Item Crop Type"; "Item Crop Type")
//                 {
//                     Editable = false;
//                 }
//                 field("Item Name"; "Item Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Revised Yield(RAW)"; "Revised Yield(RAW)")
//                 {
//                     Caption = 'Revised Yield(RAW)';
//                     Editable = false;
//                 }
//                 field("Unit of Measure Code"; "Unit of Measure Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Sowing Date Male"; "Sowing Date Male")
//                 {
//                     Editable = false;
//                 }
//                 field("Sowing Date Female"; "Sowing Date Female")
//                 {
//                     Editable = false;
//                 }
//                 field("Sowing Date Other"; "Sowing Date Other")
//                 {
//                     Editable = false;
//                 }
//                 field("Sowing Area In R"; "Sowing Area In R")
//                 {
//                     Editable = false;
//                 }
//                 field("Production Lot No."; "Production Lot No.")
//                 {
//                     Editable = false;
//                 }
//                 field("Inspection I"; "Inspection I")
//                 {
//                 }
//                 field("Inspection II"; "Inspection II")
//                 {
//                 }
//                 field("Inspection III"; "Inspection III")
//                 {
//                 }
//                 field("Inspection IV"; "Inspection IV")
//                 {
//                 }
//                 field("Inspection QC"; "Inspection QC")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             group("To Unselect")
//             {
//                 Caption = 'To Unselect';
//                 Image = Confirm;
//                 action("Unselect All Inspection I")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection I", FALSE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Unselect All Inspection II")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection II", FALSE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Unselect All Inspection III")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection III", FALSE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Unselect All Inspection IV")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection IV", FALSE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Unselect All Inspection QC")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection QC", FALSE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//             }
//             group("To Select")
//             {
//                 Caption = 'To Select';
//                 Image = Confirm;
//                 action("Select All Inspection I")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection I", TRUE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Select All Inspection II")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection II", TRUE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Select All Inspection III")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection III", TRUE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Select All Inspection IV")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection IV", TRUE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Select All Inspection QC")
//                 {
//                     Image = Process;

//                     trigger OnAction()
//                     var
//                         recGotTestingMaster: Record "50022";
//                     begin
//                         MODIFYALL("Inspection QC", TRUE);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         /*
//         GetField;
//         SowingReportHead.SETRANGE(SowingReportHead."No.","Document No.");
//         IF SowingReportHead.FIND('-') THEN BEGIN
//           IF SowingReportHead.Status = SowingReportHead.Status::Open THEN BEGIN
//             "FSIO No.Editable" := TRUE;
//             "FSIO Line No.Editable" := TRUE;
//             "Grower CodeEditable" := TRUE;
//             "Grower NameEditable" := TRUE;
//             "Taluka/MandalEditable" := TRUE;
//             VillageEditable := TRUE;
//             DistrictEditable := TRUE;
//             "Crop CodeEditable" := TRUE;
//             "Variety CodeEditable" := TRUE;
//             "Contracted AcresEditable" := TRUE;
//             "Area Issued In AcresEditable" := TRUE;
//             "Lot No. (Male)Editable" := TRUE;
//             "Lot No. (Female)Editable" := TRUE;
//           END

//           ELSE
//           BEGIN
//             "FSIO No.Editable" := FALSE;
//             "FSIO Line No.Editable" := FALSE;
//             "Grower CodeEditable" := FALSE;
//             "Grower NameEditable" := FALSE;
//             "Taluka/MandalEditable" := FALSE;
//             VillageEditable := FALSE;
//             DistrictEditable := FALSE;
//             "Crop CodeEditable" := FALSE;
//             "Variety CodeEditable" := FALSE;
//             "Contracted AcresEditable" := FALSE;
//             "Area Issued In AcresEditable" := FALSE;
//             "Lot No. (Male)Editable" := FALSE;
//             "Lot No. (Female)Editable" := FALSE;

//           END;
//         END;
//         OnAfterGetCurrRecord;
//           */
//         //PBS
//         SowingReportHead.RESET;
//         IF SowingReportHead.GET(Rec."Document No.") THEN BEGIN
//             IF SowingReportHead.Type = SowingReportHead.Type::Certified THEN
//                 LotNoEditable := TRUE;
//         END;
//         EditableCropTypeHyrbid := FALSE;
//         EditableCropTypeImproved := FALSE;
//         Rec.CALCFIELDS("Item Crop Type");
//         IF Rec."Item Crop Type" = Rec."Item Crop Type"::Hybrid THEN
//             EditableCropTypeHyrbid := TRUE;
//         IF Rec."Item Crop Type" = Rec."Item Crop Type"::Improved THEN
//             EditableCropTypeImproved := TRUE;

//     end;

//     trigger OnInit()
//     begin
//         /*
//         TransplantingDatesFemaleVisibl := TRUE;
//         TransplantingDatesMaleVisible := TRUE;
//         "Soaking Date Male IIIVisible" := TRUE;
//         "Soaking Date Male IIVisible" := TRUE;
//         "Soaking Dates Male IVisible" := TRUE;
//         "Soaking Dates FemaleVisible" := TRUE;
//         "Sowing Date(Female)Visible" := TRUE;
//         "Sowing Date(Male)Visible" := TRUE;
//         "Transplanting DateVisible" := TRUE;
//         "Soaking DatesVisible" := TRUE;
//         "Standing Area In AcresVisible" := TRUE;
//         "Area Issued In AcresEditable" := TRUE;
//         "Contracted AcresEditable" := TRUE;
//         DistrictEditable := TRUE;
//         VillageEditable := TRUE;
//         "Taluka/MandalEditable" := TRUE;
//         "Grower NameEditable" := TRUE;
//         "Grower CodeEditable" := TRUE;
//         "FSIO Line No.Editable" := TRUE;
//         "FSIO No.Editable" := TRUE;
//         */

//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         FillContractParams;
//         /*//Test
//         VALIDATE (Description, OrganiserFilter);
//         VALIDATE ("Season Code", SeasonFilter);
//         VALIDATE (Code, ContractFilter);
//         VALIDATE ("Field Assistant", FieldAssistantCode);

//         Contract.GET (Code);
//         Contract.TESTFIELD(Contract.Status, Contract.Status::Closed);
//         VALIDATE ("Pay-to Type", Contract."Pay-to Type");
//         *///Test

//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         /*
//         FillContractParams;

//         IF "Document No."<>''THEN
//         IF SowingReport.GET("Document No.") THEN
//         IF SowingReport."Hybrid Type" <> SowingReport."Hybrid Type"::" " THEN
//         VALIDATE("Hybrid Type",SowingReport."Hybrid Type");
//         GetField;
//         OnAfterGetCurrRecord;
//          */
//         //PBS
//         LotNoEditable := FALSE;

//     end;

//     trigger OnOpenPage()
//     begin
//         /*
//         GetField;
//         SowingReportHead.SETRANGE(SowingReportHead."No.","Document No.");
//         IF SowingReportHead.FIND('-') THEN BEGIN
//           IF SowingReportHead.Status = SowingReportHead.Status::Open THEN BEGIN
//             "FSIO No.Editable" := TRUE;
//             "FSIO Line No.Editable" := TRUE;
//             "Grower CodeEditable" := TRUE;
//             "Grower NameEditable" := TRUE;
//             "Taluka/MandalEditable" := TRUE;
//             VillageEditable := TRUE;
//             DistrictEditable := TRUE;
//             "Crop CodeEditable" := TRUE;
//             "Variety CodeEditable" := TRUE;
//             "Contracted AcresEditable" := TRUE;
//             "Area Issued In AcresEditable" := TRUE;
//             "Lot No. (Male)Editable" := TRUE;
//             "Lot No. (Female)Editable" := TRUE;
//           END

//           ELSE
//           BEGIN
//             "FSIO No.Editable" := FALSE;
//             "FSIO Line No.Editable" := FALSE;
//             "Grower CodeEditable" := FALSE;
//             "Grower NameEditable" := FALSE;
//             "Taluka/MandalEditable" := FALSE;
//             VillageEditable := FALSE;
//             DistrictEditable := FALSE;
//             "Crop CodeEditable" := FALSE;
//             "Variety CodeEditable" := FALSE;
//             "Contracted AcresEditable" := FALSE;
//             "Area Issued In AcresEditable" := FALSE;
//             "Lot No. (Male)Editable" := FALSE;
//             "Lot No. (Female)Editable" := FALSE;

//           END;
//         END;
//         */
//         EditableCropTypeHyrbid := FALSE;
//         EditableCropTypeImproved := FALSE;
//         Rec.CALCFIELDS("Item Crop Type");
//         IF Rec."Item Crop Type" = Rec."Item Crop Type"::Hybrid THEN
//             EditableCropTypeHyrbid := TRUE;
//         IF Rec."Item Crop Type" = Rec."Item Crop Type"::Improved THEN
//             EditableCropTypeImproved := TRUE;

//     end;

//     var
//         SowingReport: Record "50018";
//         Contract: Record "50016";
//         Organiser: Record "23";
//         Season: Record "50009";
//         ContractLines: Record "50017";
//         FieldAssistant: Record "13";
//         LotInformation: Record "6505";
//         OrganiserFilter: Code[20];
//         SeasonFilter: Code[20];
//         ContractFilter: Code[20];
//         Conf_001: Label 'Do you want to post the sowing report?';
//         CONF_002: Label 'Do you want to change the field assistant code for all the sowing report lines?';
//         ERR_001: Label 'This contract has not been posted.';
//         ERR_002: Label 'No sowing report lines created.';
//         FieldAssistantCode: Code[20];
//         ItemCode: Code[20];
//         ProductCode: Code[20];
//         ContractLineCount: Integer;
//         ERR_003: Label 'Lot already exists in the lot master in raw stage.';
//         MSG_001: Label 'There is no contract for the organizer %1 in the season %2.';
//         MSG_002: Label 'The sowing report has been posted for contract %1.';
//         SowingReportHead: Record "50017";
//         [InDataSet]
//         "FSIO No.Editable": Boolean;
//         [InDataSet]
//         "FSIO Line No.Editable": Boolean;
//         [InDataSet]
//         "Grower CodeEditable": Boolean;
//         [InDataSet]
//         "Grower NameEditable": Boolean;
//         [InDataSet]
//         "Taluka/MandalEditable": Boolean;
//         [InDataSet]
//         VillageEditable: Boolean;
//         [InDataSet]
//         DistrictEditable: Boolean;
//         [InDataSet]
//         "Crop CodeEditable": Boolean;
//         [InDataSet]
//         "Variety CodeEditable": Boolean;
//         [InDataSet]
//         "Contracted AcresEditable": Boolean;
//         [InDataSet]
//         "Area Issued In AcresEditable": Boolean;
//         [InDataSet]
//         "Lot No. (Male)Editable": Boolean;
//         [InDataSet]
//         "Lot No. (Female)Editable": Boolean;
//         [InDataSet]
//         "Standing Area In AcresVisible": Boolean;
//         [InDataSet]
//         "Soaking DatesVisible": Boolean;
//         [InDataSet]
//         "Transplanting DateVisible": Boolean;
//         [InDataSet]
//         "Sowing Date(Male)Visible": Boolean;
//         [InDataSet]
//         "Sowing Date(Female)Visible": Boolean;
//         [InDataSet]
//         "Soaking Dates FemaleVisible": Boolean;
//         [InDataSet]
//         "Soaking Dates Male IVisible": Boolean;
//         [InDataSet]
//         "Soaking Date Male IIVisible": Boolean;
//         [InDataSet]
//         "Soaking Date Male IIIVisible": Boolean;
//         [InDataSet]
//         TransplantingDatesMaleVisible: Boolean;
//         [InDataSet]
//         TransplantingDatesFemaleVisibl: Boolean;
//         LotNoEditable: Boolean;
//         "---------------------Editable------------": Integer;
//         EditableCropTypeHyrbid: Boolean;
//         EditableCropTypeImproved: Boolean;

//     [Scope('Internal')]
//     procedure SetContractFilters()
//     begin
//         /*//SSPL
//       //SetContractFilters
//       ContractFilter := '';
//       Contract.SETFILTER ("Organiser Code", OrganiserFilter);
//       Contract.SETFILTER ("Season Code", SeasonFilter);
//       IF Contract.FIND('-') THEN BEGIN
//         ContractFilter := Contract."No.";
//         ProductCode := Contract."Product Code";
//         ItemCode := Contract."Item No.";
//         Rec.RESET;
//         Rec.SETFILTER ("Document No.", ContractFilter);
//         FillContractParams();
//       END
//       ELSE MESSAGE (MSG_001, OrganiserFilter, SeasonFilter);
//        */

//     end;

//     [Scope('Internal')]
//     procedure FillContractParams()
//     begin
//         /*
//        //FillContractParams
//        Description := OrganiserFilter;
//        "Season Code" := SeasonFilter;
//        Code := ContractFilter;
//        "Field Assistant" := FieldAssistantCode;
//        "Product Code" := ProductCode;
//        "Item No." := ItemCode;
//        "Seed Type" := Contract."Seed Type";

//        */

//     end;

//     [Scope('Internal')]
//     procedure PostSowingLines()
//     begin
//         /*//SSPL
//         //PostSowingLines
//         IF Rec.COUNT = 0 THEN ERROR(ERR_002);
//         IF CONFIRM (Conf_001) THEN BEGIN
//           Rec.FIND ('-');
//           Contract.GET ("Document No.");
//           ContractLines.SETRANGE("Entry No.", "Document No.");
//           IF ContractLines.FIND ('+') THEN ContractLineCount := ContractLines."Indentor Code";
//           REPEAT
//             TESTFIELD ("Farmer Code");
//             TESTFIELD ("Sowing Acres");
//           //  TESTFIELD ("Lot No. (Male)");
//             TESTFIELD ("Lot No. (Female)");
//             TESTFIELD ("Assigned Lot No.");
//           //  TESTFIELD ("Parent Seed Quantity (Male)");
//            // TESTFIELD ("Def.Test");
//           //  TESTFIELD ("Date of Male Sowing");
//             TESTFIELD ("Field Assistant");
//             TESTFIELD ("Date of Female Sowing");

//             LotNumberCheck.LotItemValidation (Rec."Assigned Lot No.", Rec."Item No.", Rec."Season Code",
//               Contract."Production Centre");
//             ContractLines.RESET;
//             ContractLines.SETRANGE (ContractLines."Assigned Lot No.", Rec."Assigned Lot No.");
//             ContractLines.SETRANGE (ContractLines."Item Type", ContractLines."Item Type"::"1");
//             IF ContractLines.FIND ('-') THEN ERROR (ERR_003);

//             ContractLines.INIT;
//             ContractLineCount := ContractLineCount + 10000;
//             ContractLines."Entry No." := "Document No.";
//             ContractLines."Indentor Code" := ContractLineCount;
//             ContractLines.INSERT (TRUE);
//             ContractLines.VALIDATE (ContractLines."Indentor Name", Rec."Farmer Code");
//             ContractLines.VALIDATE (ContractLines."Field Assistant", Rec."Field Assistant");
//            // ContractLines.VALIDATE (ContractLines."Contracted Acres", Rec.Result);
//             ContractLines.VALIDATE (ContractLines."Lot No. (Male)", Rec."Lot No. (Male)");
//             ContractLines.VALIDATE (ContractLines."Lot No. (Female)", Rec."Lot No. (Female)");
//             ContractLines.VALIDATE (ContractLines."Balance Qty", Rec."Parent Seed Quantity (Male)");
//             //ContractLines.VALIDATE (ContractLines."Female PS Qty as per contract", Rec."Def.Test");
//             ContractLines.VALIDATE (ContractLines.Season, Rec."Date of Male Sowing");
//             ContractLines.VALIDATE (ContractLines.Posted, Rec."Date of Female Sowing");
//             ContractLines.VALIDATE (ContractLines."Sowing Acres", Rec."Sowing Acres");
//             ContractLines.VALIDATE (ContractLines."Pay-to Type", Rec."Pay-to Type");
//             ContractLines.VALIDATE (ContractLines."Crop Code", Rec."Crop Code");
//             ContractLines.VALIDATE (ContractLines."Variety Code", Rec."Variety Code");
//             ContractLines.VALIDATE (ContractLines."Parent Seed Code (Male)", Rec."Parent Seed Code (Male)");
//             ContractLines.VALIDATE (ContractLines."Parent Seed Code (Female)", Rec."Parent Seed Code (Female)");
//             //ContractLines.VALIDATE (ContractLines."Vegetative Date (Expected)", Rec.Pass);
//             //ContractLines.VALIDATE (ContractLines."Flowering Date (Expected)", Rec.Fail);
//             //ContractLines.VALIDATE (ContractLines."Grain Filling (Expected)", Rec.Level);
//             //ContractLines.VALIDATE (ContractLines."Harvest Start Date (Expected)", Rec."Averaging Required");

//             ContractLines.VALIDATE (ContractLines."Item No.", Rec."Item No.");
//             ContractLines.VALIDATE (ContractLines."Seed Type", Rec."Seed Type");
//             ContractLines.VALIDATE (ContractLines."Assigned Lot No.", Rec."Assigned Lot No.");
//             ContractLines.VALIDATE (ContractLines."Field Assistant", Rec."Field Assistant");
//             ContractLines.VALIDATE (ContractLines.Source, ContractLines.Source::"1");
//             ContractLines.VALIDATE (ContractLines."Item Type", ContractLines."Item Type"::"1");

//             ContractLines.VALIDATE (ContractLines."Organiser Code", OrganiserFilter);
//             ContractLines.MODIFY (TRUE);

//             LotInformation.SETRANGE ("Item No.", Rec."Item No.");
//             LotInformation.SETRANGE ("Lot No.", Rec."Assigned Lot No.");
//             IF NOT LotInformation.FIND ('-') THEN BEGIN
//               LotInformation.INIT;
//               LotInformation.VALIDATE ("Item No.", Rec."Item No.");
//               LotInformation.VALIDATE ("Lot No.", Rec."Assigned Lot No.");
//               LotInformation.VALIDATE (Blocked, TRUE);
//               LotInformation.INSERT (TRUE);
//             END;
//           UNTIL (Rec.NEXT <=0);
//           Rec.DELETEALL;
//           MESSAGE (MSG_002, ContractFilter);
//         END;
//          */

//     end;

//     [Scope('Internal')]
//     procedure GetContract()
//     begin
//         /*
//         Contract.RESET;
//         Contract.SETRANGE(Contract.Status, Contract.Status::Closed);
//         IF FORM.RUNMODAL(0, Contract) = ACTION::LookupOK THEN BEGIN
//           Contract.TESTFIELD (Status, Contract.Status::Closed);
//           ContractFilter := Contract."No.";
//           OrganiserFilter := Contract."Organiser Code";
//           SeasonFilter := Contract."Season Code";
//           ProductCode := Contract."Product Code";
//           ItemCode := Contract."Item No.";
//           Rec.RESET;
//           Rec.SETFILTER ("Document No.", ContractFilter);
//           FillContractParams();
//         END;
//          */

//     end;

//     [Scope('Internal')]
//     procedure GetField()
//     begin
//         /*
//         IF "Hybrid Type" = "Hybrid Type"::"OP Hybrid" THEN BEGIN
//           "Standing Area In AcresVisible" := TRUE;
//           "Soaking DatesVisible" := TRUE;
//           "Transplanting DateVisible" := TRUE;
//           "Sowing Date(Male)Visible" := FALSE;
//           "Sowing Date(Female)Visible" := FALSE;
//           "Soaking Dates FemaleVisible" := FALSE;
//           "Soaking Dates Male IVisible" := FALSE;
//           "Soaking Date Male IIVisible" := FALSE;
//           "Soaking Date Male IIIVisible" := FALSE;
//           TransplantingDatesMaleVisible := FALSE;
//           TransplantingDatesFemaleVisibl := FALSE;

//         END ;
//         IF "Hybrid Type" = "Hybrid Type"::Others THEN BEGIN
//           "Standing Area In AcresVisible" := TRUE;
//           "Sowing Date(Male)Visible" := TRUE;
//           "Sowing Date(Female)Visible" := TRUE;
//           "Soaking Dates FemaleVisible" := FALSE;
//           "Soaking Dates Male IVisible" := FALSE;
//           "Soaking Date Male IIVisible" := FALSE;
//           "Soaking Date Male IIIVisible" := FALSE;
//           TransplantingDatesMaleVisible := FALSE;
//           TransplantingDatesFemaleVisibl := FALSE;

//         END;

//         IF "Hybrid Type" = "Hybrid Type"::"Hybrid Paddy" THEN BEGIN
//           "Standing Area In AcresVisible" := TRUE;
//           "Sowing Date(Male)Visible" := FALSE;
//           "Sowing Date(Female)Visible" := FALSE;
//           "Soaking Dates FemaleVisible" := TRUE;
//           "Soaking Dates Male IVisible" := TRUE;
//           "Soaking Date Male IIVisible" := TRUE;
//           "Soaking Date Male IIIVisible" := TRUE;
//           TransplantingDatesMaleVisible := TRUE;
//           TransplantingDatesFemaleVisibl := TRUE;

//         END;
//         *///SSPL

//     end;

//     [Scope('Internal')]
//     procedure UpdateFields()
//     begin
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         GetField;
//     end;
// }

