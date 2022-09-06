#pragma warning disable
page 50046 "Risk Factor Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Risk Factor Master";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;

                }
                field(Season; Season)
                {
                    ApplicationArea = All;

                }
                field(Variety; Variety)
                {
                    ApplicationArea = all;

                }
                field("Risk Factor %"; "Risk Factor %")
                {
                    ApplicationArea = all;
                }
                field("Average Yield / Acre in MT"; "Average Yield / Acre in MT")
                {
                    ApplicationArea = all;
                }
                field("Seed Rate / Acre"; "Seed Rate / Acre")
                {
                    ApplicationArea = all;
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