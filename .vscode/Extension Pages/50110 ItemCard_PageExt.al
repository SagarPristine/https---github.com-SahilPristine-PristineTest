pageextension 50110 ItemCardExt extends "Item Card"
{
    layout
    {

        addafter("Base Unit of Measure")
        {

            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = all;
            }
            field("Crop Code"; Rec."Crop Code")
            {
                ApplicationArea = all;
                TableRelation = "Crop Master"."Code";

                trigger OnValidate()
                var

                begin

                end;
            }
            field("Class of Seeds"; Rec."Class of Seeds")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    EditFGPackSize: Boolean;
                    EditFSPackSize: Boolean;
                begin
                    IF Rec."Class of Seeds" = Rec."Class of Seeds"::TL THEN
                        EditFGPackSize := TRUE
                    ELSE
                        EditFGPackSize := FALSE;
                    IF Rec."Class of Seeds" = Rec."Class of Seeds"::Foundation THEN
                        EditFSPackSize := TRUE
                    ELSE
                        EditFSPackSize := FALSE;
                    CurrPage.UPDATE;
                end;
            }
            field("FG Pack Size"; Rec."FG Pack Size")
            {
                ApplicationArea = all;
            }

            field("Secondary Pack"; Rec."Secondary Pack")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Secondary Pack field.';
            }

            field("Item Group"; Rec."Variety Code")
            {
                ApplicationArea = all;
                LookupPageID = Varieties;
            }

            field("Crop Type"; Rec."Crop Type")
            {
                ApplicationArea = all;
            }
            field("Hybrid Type"; Rec."Hybrid Type")
            {
                ApplicationArea = all;
            }
            field("Male/Female"; Rec."Male/Female")
            {
                ToolTip = 'Specifies the value of the Male/Female field.';
                ApplicationArea = All;
            }

        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}