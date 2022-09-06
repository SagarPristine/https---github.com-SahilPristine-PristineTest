page 50039 "Parent Seed Card"
{
    PageType = Card;
    SourceTable = "Parent Seed Master";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Variety Type"; REC."Variety Type")
                {
                    ApplicationArea = all;
                }
                field("Variety Code"; REC."Variety Code")
                {
                    ApplicationArea = all;
                }
                field("Sequence No"; REC."Sequence No")
                {
                    ApplicationArea = all;
                }
                field("Variety Name"; REC."Variety Name")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Code(Male)"; REC."Parent Seed Code(Male)")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF Rec."Variety Type" = Rec."Variety Type"::Breeder THEN BEGIN
                            IF Rec."Parent Seed Code(Female)" <> '' THEN
                                ERROR('For Variety Type Breeder you can only select either Male or Female, Not Both.');
                        END;
                    end;
                }
                field("Parent Seed Name(Male)"; REC."Parent Seed Name(Male)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Code(Female)"; REC."Parent Seed Code(Female)")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF Rec."Variety Type" = Rec."Variety Type"::Breeder THEN BEGIN
                            IF Rec."Parent Seed Code(Male)" <> '' THEN
                                ERROR('For Variety Type Breeder you can only select either Male or Female, Not Both.');
                        END;
                    end;
                }
                field("Parent Seed Name(Female)"; REC."Parent Seed Name(Female)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Code(Other)"; REC."Parent Seed Code(Other)")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Name(Other)"; REC."Parent Seed Name(Other)")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
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
    begin

    end;

    trigger OnOpenPage()
    begin
    end;

    var

}

