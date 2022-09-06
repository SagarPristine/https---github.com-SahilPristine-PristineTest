page 50079 "Inspection Subform 3"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER(Isolation));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(South; Rec.South)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the South field.';
                }
                field("South Border Male Barrier"; Rec."South Border Male Barrier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the South Border Male Barrier field.';
                }
                field("Production Lot No."; rec."Production Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Organizer/Co-ordinator Name"; rec."Organizer Code")
                {
                    ApplicationArea = all;
                    Caption = 'Organizer/Co-ordinator Name';
                }
                field("Grower/Land Owner Name"; rec."Grower/Land Owner Name")
                {
                    ApplicationArea = all;
                }
                field("Grower Village"; rec."Grower Village")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = all;
                }
                field("Crop Code"; rec."Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Item Class of Seeds"; rec."Item Class of Seeds")
                {
                    ApplicationArea = all;
                }
                field("Item Crop Type"; rec."Item Crop Type")
                {
                    ApplicationArea = all;
                }
                field(North; Rec.North)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the North field.';
                }
                field("North Border Male Barrier"; Rec."North Border Male Barrier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the North Border Male Barrier field.';
                }
                field(East; Rec.East)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the East field.';
                }
                field("East Border Male Barrier"; Rec."East Border Male Barrier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the East Border Male Barrier field.';
                }
                field(West; Rec.West)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the West field.';
                }
                field("West Border Male Barrier"; Rec."West Border Male Barrier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the West Border Male Barrier field.';
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

