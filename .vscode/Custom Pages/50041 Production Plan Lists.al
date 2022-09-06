page 50041 "Production Plan Lists"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production Plan Header";
    AboutTitle = 'Production Plan List';
    CardPageId = "Production Plan";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Production Plan No."; Rec."Production Plan No.")
                {
                    ApplicationArea = All;

                }
                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Planning Worksheet")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    // ProductionPlanWorksheet: Page "Production Plan Worksheet";
                    ProductionPlanLine: Record "Production Plan Line";
                begin
                    // ProductionPlanLine.DeleteAll();
                    // Productionplanline.Reset();
                    // Productionplanline.SetRange("Production Plan No.", Rec."Production Plan No.");
                    // if not Productionplanline.FindFirst() then begin
                    //     Productionplanline.Init();
                    //     Productionplanline."Production Plan No." := Rec."Production Plan No.";
                    //     Productionplanline.Season := Rec.Season;
                    //     ProductionPlanLine."Line No." := 10000;
                    //     Productionplanline.Insert();
                    // end;
                    // Commit();
                    // ProductionPlanWorksheet.SetTableView(ProductionPlanLine);
                    // ProductionPlanWorksheet.SetValues(Rec);
                    // ProductionPlanWorksheet.RunModal();
                end;
            }
        }
    }
}