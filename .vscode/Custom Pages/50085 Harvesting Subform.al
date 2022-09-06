page 50085 "Inspection Subform 8"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER(Harvesting));

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Harvesting Date"; Rec."Harvesting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Harvesting Date field.';
                    Editable = false;
                }

                field("Production Lot No."; rec."Production Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Organizer/Co-ordinator Name"; rec."Organizer Code")
                {
                    ApplicationArea = all;
                    Caption = 'Organizer/Co-ordinator Name';
                    Editable = false;
                }
                field("Grower/Land Owner Name"; rec."Grower/Land Owner Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Grower Village"; rec."Grower Village")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Crop Code"; rec."Crop Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Class of Seeds"; rec."Item Class of Seeds")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Crop Type"; rec."Item Crop Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("PLD / Cancellation Area"; Rec."PLD / Cancellation Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PLD / Cancellation Area field.';
                    trigger OnValidate()
                    var
                        InspectionLn: Record "Inspection Line";
                    begin
                        InspectionLn.Reset();
                        InspectionLn.SetRange(Type, InspectionLn.Type::Vegetative);
                        InspectionLn.SetRange("Production Lot No.", Rec."Production Lot No.");
                        InspectionLn.FindFirst();
                        InspectionLn.TestField(InspectionLn."Net Standing Area (in Acres)");
                        rec."Yield Per Acre" := rec."Actual tare weight" / InspectionLn."Net Standing Area (in Acres)" - rec."PLD / Cancellation Area"
                    end;
                }
                field("PLD / Cancellation Reason"; Rec."PLD / Cancellation Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PLD / Cancellation Reason field.';
                }
                field("Expected Arrival Qty"; Rec."Expected Arrival Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Arrival Qty field.';
                }
                field("Expected Arrival Date"; Rec."Expected Arrival Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Arrival Date field.';
                }
                field("Actual number of bags"; Rec."Actual number of bags")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual number of bags field.';
                }
                field("Actual tare weight"; Rec."Actual tare weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual tare weight field.';
                }
                field("Yield Per Acre"; Rec."Yield Per Acre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Yield Per Acre field.';

                }



            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnDeleteRecord(): Boolean
    var
    begin
    end;

    var

}

