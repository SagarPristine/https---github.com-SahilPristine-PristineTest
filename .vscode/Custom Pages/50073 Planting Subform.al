page 50073 "Planting List Subform"
{
    AutoSplitKey = true;
    Caption = 'Line';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    //PopulateAllFields = true;
    //SaveValues = true;
    SourceTable = "Planting List Line";
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document SubType"; Rec."Document SubType")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document SubType field.';
                }

                field("BSIO No."; "BSIO No.")
                {
                    Caption = 'BSIO/FSIO No.';
                    ApplicationArea = all;

                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                    trigger OnValidate()
                    var
                        SalesShptLn: Record "Sales Shipment Line";
                        InspectionMandatoryRules: Record "Inspection Mandatory Rules";
                    begin
                        SalesShptLn.Reset();
                        SalesShptLn.SetRange("Document No.", Rec."BSIO No.");
                        SalesShptLn.SetRange("Line No.", rec."Document Line No.");
                        if SalesShptLn.FindFirst() then begin
                            Rec."Item No." := SalesShptLn."No.";
                            rec."Crop Code" := SalesShptLn."Crop Code";
                            rec."Variety Code" := SalesShptLn."Variety Code";
                            Rec."Seed Qty" := SalesShptLn.Quantity;
                            InspectionMandatoryRules.Reset();
                            if InspectionMandatoryRules.Get(SalesShptLn."Variety Code") then begin
                                if InspectionMandatoryRules.Nursery then
                                    Rec.Nursery := true;
                                if InspectionMandatoryRules.Vegetative then
                                    rec.Vegetative := true;
                                if InspectionMandatoryRules.Isolation then
                                    Rec.Isolation := true;
                                if InspectionMandatoryRules."Vegetative Roughing" then
                                    Rec."Vegetative Roughing" := true;
                                if InspectionMandatoryRules."Pre-Flowering" then
                                    Rec."Pre-Flowering" := true;
                                if InspectionMandatoryRules.Flowering then
                                    Rec.Flowering := true;
                                if InspectionMandatoryRules.Pollination then
                                    Rec.Pollination := true;
                                if InspectionMandatoryRules."Final Roughing" then
                                    Rec."Final Roughing" := true;
                                if InspectionMandatoryRules.MaleChopping then
                                    Rec.MaleChopping := true;
                                if InspectionMandatoryRules.Harvesting then
                                    Rec.Harvesting := true;
                                if InspectionMandatoryRules.Nursery then
                                    Rec."Nursery Status" := Rec."Nursery Status"::Aligned;
                                if InspectionMandatoryRules.Vegetative then
                                    rec."Vegetative Status" := Rec."Vegetative Status"::Aligned;
                                if InspectionMandatoryRules.Isolation then
                                    Rec."Isolation Status" := Rec."Isolation Status"::Aligned;
                                if InspectionMandatoryRules."Vegetative Roughing" then
                                    Rec."Vegetative Roughing Status" := Rec."Vegetative Roughing Status"::Aligned;
                                if InspectionMandatoryRules."Pre-Flowering" then
                                    Rec."Pre-Flowering Status" := Rec."Pre-Flowering Status"::Aligned;
                                if InspectionMandatoryRules.Flowering then
                                    Rec."Flowering Status" := Rec."Pre-Flowering Status"::Aligned;
                                if InspectionMandatoryRules.Pollination then
                                    Rec."Pollination Status" := Rec."Pollination Status"::Aligned;
                                if InspectionMandatoryRules."Final Roughing" then
                                    Rec."Final Roughing Status" := Rec."Final Roughing Status"::Aligned;
                                if InspectionMandatoryRules.MaleChopping then
                                    Rec."MaleChopping Status" := Rec."MaleChopping Status"::Aligned;
                                if InspectionMandatoryRules.Harvesting then
                                    Rec."Harvesting Status" := Rec."Harvesting Status"::Aligned;
                            end else
                                Error('There is no Inspection Mondatory rules define for this Variety %1', SalesShptLn."Variety Code");
                        end else begin
                            Rec."Item No." := '';
                            rec."Crop Code" := '';
                            rec."Variety Code" := '';
                            Rec."Item Name" := '';
                            Rec."Seed Qty" := 0;
                            Rec.Nursery := false;
                            Rec.Vegetative := false;
                            Rec.Isolation := false;
                            Rec."Vegetative Roughing" := false;
                            Rec."Pre-Flowering" := false;
                            rec.Flowering := false;
                            rec.Pollination := false;
                            rec."Final Roughing" := false;
                            Rec.MaleChopping := false;
                            Rec.Harvesting := false;
                            Rec."Nursery Status" := Rec."Nursery Status"::Pending;
                            Rec."Vegetative Status" := Rec."Vegetative Status"::Pending;
                            Rec."Isolation Status" := Rec."Isolation Status"::Pending;
                            Rec."Vegetative Roughing Status" := Rec."Vegetative Roughing Status"::Pending;
                            Rec."Pre-Flowering Status" := Rec."Pre-Flowering Status"::Pending;
                            Rec."Flowering Status" := Rec."Flowering Status"::Pending;
                            Rec."Pollination Status" := Rec."Pollination Status"::Pending;
                            Rec."Final Roughing Status" := Rec."Final Roughing Status"::Pending;
                            Rec."MaleChopping Status" := Rec."MaleChopping Status"::Pending;
                            Rec."Harvesting Status" := Rec."Harvesting Status"::Pending;
                        end;
                        CurrPage.Update();
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                    Editable = false;
                }

                field("Organizer Code"; "Organizer Code")
                {
                    ApplicationArea = all;
                    Caption = 'Organiser Code';
                    Visible = false;
                }
                field("Organizer Name"; "Organizer Name")
                {
                    ApplicationArea = all;
                }
                field("Grower Owner"; "Grower Owner")
                {
                    Editable = true;
                    LookupPageID = Growers;
                    ApplicationArea = all;
                    Caption = 'Grower Code';
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Grower/Land Owner Name"; "Grower/Land Owner Name")
                {
                    Editable = "Grower NameEditable";
                    ApplicationArea = all;
                    Caption = 'Grower Name';
                }
                field("Crop Code"; "Crop Code")
                {
                    Editable = true;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Variety Code"; "Variety Code")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Variety Code(Male)"; "Variety Code(Male)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variety Code(Female)"; "Variety Code(Female)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variety Code(Other)"; "Variety Code(Other)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variety Code(Male Name)"; "Variety Code(Male Name)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variety Code(Female Name)"; "Variety Code(Female Name)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variety Code(Other Name)"; "Variety Code(Other Name)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Item Class of Seeds"; "Item Class of Seeds")
                {
                    ApplicationArea = all;
                    Caption = 'Class of seeds';
                    Visible = false;
                }
                field("Item Crop Type"; "Item Crop Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = all;
                }
                field("Revised Yield(RAW)"; "Revised Yield(RAW)")
                {
                    Caption = 'Revised Yield(RAW)';
                    ApplicationArea = all;
                }
                field("Issued area in acre"; Rec."Issued area in acre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issued area in acre field.';
                }
                field("Production officer"; Rec."Production officer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production officer field.';
                }

                field(TFS; Rec.TFS)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TFS field.';
                }
                field("Expected Yield"; Rec."Expected Yield")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Yield field.';
                }
                field("Net standing area in acre "; Rec."Net standing area in acre ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net standing area in acre  field.';
                }
                field("Seed Qty"; Rec."Seed Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seed Qty field.';
                }
                field("Sowing Date Male"; "Sowing Date Male")
                {
                    Editable = EditableCropTypeHyrbid;
                    HideValue = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sowing Date Female"; "Sowing Date Female")
                {
                    Editable = EditableCropTypeHyrbid;
                    HideValue = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sowing Date Other"; "Sowing Date Other")
                {
                    Editable = EditableCropTypeImproved;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sowing Area In Acre"; "Sowing Area In R")
                {
                    ApplicationArea = all;

                }
                field("Production Lot No."; "Production Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Attention;
                }
                field(Nursery; Rec.Nursery)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nursery field.';
                    Editable = false;
                }

                field(Vegetative; Rec.Vegetative)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vegetative field.';
                    Editable = false;
                }

                field(Isolation; Rec.Isolation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Isolation field.';
                    Editable = false;
                }
                field("Vegetative Roughing"; Rec."Vegetative Roughing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vegetative Roughing field.';
                }

                field("Pre-Flowering"; Rec."Pre-Flowering")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pre-Flowering field.';
                    Editable = false;
                }

                field(Flowering; Rec.Flowering)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Flowering field.';
                    Editable = false;
                }
                field(Pollination; Rec.Pollination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pollination field.';
                    Editable = false;
                }
                field(MaleChopping; Rec.MaleChopping)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MaleChopping field.';
                    Editable = false;
                }
                field("Final Roughing"; Rec."Final Roughing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final Roughing field.';
                    Editable = false;
                }
                field(Harvesting; Rec.Harvesting)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Harvesting field.';
                    Editable = false;
                }
                field("Nursery Status"; Rec."Nursery Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nursery Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Vegetative Status"; Rec."Vegetative Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vegetative Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Isolation Status"; Rec."Isolation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Isolation Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Vegetative Roughing Status"; Rec."Vegetative Roughing Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vegetative Roughing Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }

                field("Pre-Flowering Status"; Rec."Pre-Flowering Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pre-Flowering Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Flowering Status"; Rec."Flowering Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Flowering Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Pollination Status"; Rec."Pollination Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pollination Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }
                field("MaleChopping Status"; Rec."MaleChopping Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MaleChopping Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }

                field("Final Roughing Status"; Rec."Final Roughing Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final Roughing Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }

                field("Harvesting Status"; Rec."Harvesting Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Harvesting Status field.';
                    Style = Unfavorable;
                    Editable = false;
                }


            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        SowingReportHead.RESET;
        IF SowingReportHead.GET(Rec."Document No.") THEN BEGIN
            IF SowingReportHead.Type = SowingReportHead.Type::Certified THEN
                LotNoEditable := TRUE;
        END;
        EditableCropTypeHyrbid := FALSE;
        EditableCropTypeImproved := FALSE;
        Rec.CALCFIELDS("Item Crop Type");
        IF Rec."Item Crop Type" = Rec."Item Crop Type"::Hybrid THEN
            EditableCropTypeHyrbid := TRUE;
        IF Rec."Item Crop Type" = Rec."Item Crop Type"::Improved THEN
            EditableCropTypeImproved := TRUE;

    end;

    trigger OnInit()
    begin


    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    var
        SowingReport: Record "Planting List Header";
        Contract: Record 50016;
        Organiser: Record 23;
        Season: Record 50009;
        ContractLines: Record 50017;
        FieldAssistant: Record 13;
        OrganiserFilter: Code[20];
        SeasonFilter: Code[20];
        ContractFilter: Code[20];
        Conf_001: Label 'Do you want to post the sowing report?';
        CONF_002: Label 'Do you want to change the field assistant code for all the sowing report lines?';
        ERR_001: Label 'This contract has not been posted.';
        ERR_002: Label 'No sowing report lines created.';
        FieldAssistantCode: Code[20];
        ItemCode: Code[20];
        ProductCode: Code[20];
        ContractLineCount: Integer;
        ERR_003: Label 'Lot already exists in the lot master in raw stage.';
        MSG_001: Label 'There is no contract for the organizer %1 in the season %2.';
        MSG_002: Label 'The sowing report has been posted for contract %1.';
        SowingReportHead: Record "Planting List Header";
        [InDataSet]
        "FSIO No.Editable": Boolean;
        [InDataSet]
        "FSIO Line No.Editable": Boolean;
        [InDataSet]
        "Grower CodeEditable": Boolean;
        [InDataSet]
        "Grower NameEditable": Boolean;
        [InDataSet]
        "Taluka/MandalEditable": Boolean;
        [InDataSet]
        VillageEditable: Boolean;
        [InDataSet]
        DistrictEditable: Boolean;
        [InDataSet]
        "Crop CodeEditable": Boolean;
        [InDataSet]
        "Variety CodeEditable": Boolean;
        [InDataSet]
        "Contracted AcresEditable": Boolean;
        [InDataSet]
        "Area Issued In AcresEditable": Boolean;
        [InDataSet]
        "Lot No. (Male)Editable": Boolean;
        [InDataSet]
        "Lot No. (Female)Editable": Boolean;
        [InDataSet]
        "Standing Area In AcresVisible": Boolean;
        [InDataSet]
        "Soaking DatesVisible": Boolean;
        [InDataSet]
        "Transplanting DateVisible": Boolean;
        [InDataSet]
        "Sowing Date(Male)Visible": Boolean;
        [InDataSet]
        "Sowing Date(Female)Visible": Boolean;
        [InDataSet]
        "Soaking Dates FemaleVisible": Boolean;
        [InDataSet]
        "Soaking Dates Male IVisible": Boolean;
        [InDataSet]
        "Soaking Date Male IIVisible": Boolean;
        [InDataSet]
        "Soaking Date Male IIIVisible": Boolean;
        [InDataSet]
        TransplantingDatesMaleVisible: Boolean;
        [InDataSet]
        TransplantingDatesFemaleVisibl: Boolean;
        LotNoEditable: Boolean;
        "---------------------Editable------------": Integer;
        EditableCropTypeHyrbid: Boolean;
        EditableCropTypeImproved: Boolean;
        PlantingListHeader: Record "Planting List Header";

    procedure GetField()
    begin


    end;


    procedure UpdateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetField;
    end;
}

