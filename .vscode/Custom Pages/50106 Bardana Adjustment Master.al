page 50106 "Bardana Adjustment Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bardana Adjustment Master";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }

                field("Arrival Seed In kg"; Rec."Arrival Seed In kg")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Arrival Seed In kg field.';
                }
                field("Adjusted Bardana in Kg"; Rec."Adjusted Bardana in Kg")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Adjusted Bardana in Kg field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}