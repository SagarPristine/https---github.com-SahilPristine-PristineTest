page 50075 "Planting List Card"
{
    PageType = Card;
    UsageCategory = None;
    RefreshOnActivate = true;
    SourceTable = "Planting List Header";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Season field.';
                }

                field("Production Centre"; Rec."Production Centre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Centre/Location Code field.';
                }
                field("Production Centre Name"; Rec."Production Centre Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Centre Name field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Organiser Code"; Rec."Organiser Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organiser/Co-ordinator Code field.';
                }
                field("Organizer Name"; Rec."Organizer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Total Sowing Area In R"; "Total Sowing Area In R")
                {
                    Caption = 'Total Sowing Area In R';
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Total Land in R Fsio"; "Total Land in R")
                {
                    Caption = 'Total Land in R Fsio';
                    Enabled = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            part(Subform; 50073)
            {
                ApplicationArea = Basic, Suite;
                Visible = Rec."Organiser Code" <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
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
                action("&Test Report")
                {
                    Caption = '&Test Report';
                    Image = TestReport;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        SowingHeader := Rec;
                        SowingHeader.SETRECFILTER;
                        REPORT.RUNMODAL(REPORT::"Sowing Test Report",TRUE,FALSE,SowingHeader);
                        */

                    end;
                }
                action(Post)
                {
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ShortcutKey = 'F9';

                    trigger OnAction()
                    var
                        PlantingListLine: Record "Planting List Line";
                        Item: Record 27;
                        InspectionHeader: Record "Inspection Header";
                        PlantingListHeader: Record "Planting List Header";
                    begin


                        Rec.TESTFIELD(Season);
                        Rec.TESTFIELD(Date);
                        Rec.TESTFIELD("Organiser Code");
                        Rec.TESTFIELD("Stage Code");

                        // PlantingListLine.RESET;
                        // PlantingListLine.SETCURRENTKEY("Document No.", "Line No.");
                        // PlantingListLine.SETRANGE("Document No.", Rec."No.");
                        // IF PlantingListLine.FINDSET THEN BEGIN
                        //     REPEAT

                        //         PlantingListLine.TestField("Issued area in acre");
                        //         PlantingListLine.TESTFIELD("Revised Yield(RAW)");
                        //         PlantingListLine.TestField("Production officer");
                        //         PlantingListLine.TestField(TFS);
                        //         PlantingListLine.TestField("Expected Yield");
                        //         PlantingListLine.TestField("Seed Qty");
                        //         PlantingListLine.TestField("Sowing Area In R");

                        //         IF PlantingListLine.Nursery = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::Nursery);
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Nursery must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Nursery must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         END;
                        //         IF PlantingListLine.Vegetative = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::Vegetative);
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Vegetative must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Vegetative must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         END;
                        //         IF PlantingListLine.Isolation = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::Isolation);
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Isolation must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Isolation must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         END;
                        //         IF PlantingListLine."Pre-Flowering" = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::"Pre Flowering Roughing");
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Pre-Flowering must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Pre-Flowering must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         END;
                        //         IF PlantingListLine.Flowering = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::"Flowering Roughing");
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Flowering must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Flowering must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         END;
                        //         IF PlantingListLine.MaleChopping = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::MaleChoping);
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('MaleChopping must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('MaleChopping must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         END;
                        //         IF PlantingListLine."Final Roughing" = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::"Final Roughing");
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Final Roughing must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Final Roughing must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         END;
                        //         IF PlantingListLine.Harvesting = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::Harvesting);
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Harvesting must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Harvesting must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //         end;
                        //         IF PlantingListLine."Vegetative Roughing" = TRUE THEN BEGIN
                        //             InspectionHeader.RESET;
                        //             InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //             InspectionHeader.SETRANGE(Type, InspectionHeader.Type::"Vegetative Roughing");
                        //             InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //             IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                 IF (InspectionHeader.Posted <> TRUE) THEN
                        //                     ERROR('Vegetative Roughing must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             END ELSE
                        //                 ERROR('Vegetative Roughing must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");

                        //             IF PlantingListLine.Pollination = TRUE THEN BEGIN
                        //                 InspectionHeader.RESET;
                        //                 InspectionHeader.SETCURRENTKEY(Type, "Arrival Plan No.");
                        //                 InspectionHeader.SETRANGE(Type, InspectionHeader.Type::Pollination);
                        //                 InspectionHeader.SETRANGE("Arrival Plan No.", PlantingListLine."Document No.");
                        //                 IF InspectionHeader.FINDFIRST THEN BEGIN
                        //                     IF (InspectionHeader.Posted <> TRUE) THEN
                        //                         ERROR('Pollination must be Posted for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //                 END ELSE
                        //                     ERROR('Pollination Roughing must be done for Production Lot No. %1. It looks like it have not done yet.', PlantingListLine."Production Lot No.");
                        //             end;
                        //         END;
                        //     UNTIL PlantingListLine.NEXT = 0;
                        // END;
                        Rec.PostSowingReport;
                        CurrPage.UPDATE;
                    end;
                }
                action("Create Production Lot")
                {
                    Caption = 'Create Production Lot';
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        Rec.CreateProductionLotNo(Rec);
                        CurrPage.UPDATE;
                    end;
                }
                action("Released")
                {
                    Caption = 'Release';
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Release;
                        CurrPage.UPDATE;
                    end;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnDeleteRecord(): Boolean
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin

    end;

    trigger OnOpenPage()
    begin
    end;

    var
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        SowingHeader: Record "Planting List Header";
        Selection: Integer;
        Text000: Label '&Sowing Issue,&Post';
        SowingLine: Record "Planting List Line";
        Item: Record 27;
        ItemTab: Record 27;
        ILE: Record 32;
        ValueEntry: Record 5802;
        ManualLOTBoolean: Boolean;
        RecSowingLine: Record "Planting List Line";
        ContactAdminText003: Label 'User does not have permission to Create or Modify Record. Please contact your System Administrator.';
        recUL: Record 50015;
        CanView: Boolean;
        CanInsert: Boolean;
        NoSeriesMgt: Codeunit 396;
        purchSetup: Record 312;
}

