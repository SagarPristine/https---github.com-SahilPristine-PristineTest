#pragma warning disable AL0604
page 50042 "Production Plan Subform"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "production plan line";
    AutoSplitKey = true;
    Caption = 'Prod. Plan Variety wise details';


    layout
    {
        area(Content)
        {
            grid("Variety Wise Production Details")
            {
                repeater(Subform)
                {


                    field(Variety; Variety)
                    {
                        ApplicationArea = all;
                        Style = Favorable;
                        trigger OnValidate()
                        begin
                            SetColumnCaptions();
                        end;

                    }
                    field("Dynamic Column 1"; "Dynamic Column 1")
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,5,,' + Dynamiccolumn1;
                        Style = StrongAccent;
                        trigger OnValidate()
                        begin
                            "Kharif Shortfall Qty" := ("Dynamic Column 1" - "Dynamic Column 4" - "Dynamic Column 5") + ("Dynamic Column 2" - "Dynamic Column 6");
                        end;


                    }
                    field("Dynamic Column 2"; "Dynamic Column 2")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn2;
                        Style = StrongAccent;
                        trigger OnValidate()
                        begin
                            "Kharif Shortfall Qty" := ("Dynamic Column 1" - "Dynamic Column 4" - "Dynamic Column 5") + ("Dynamic Column 2" - "Dynamic Column 6");
                        end;

                    }
                    field("Dynamic Column 3"; "Dynamic Column 3")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn3;
                        Style = StrongAccent;

                    }
                    field("Buffer for Storage"; "Buffer for Storage")
                    {
                        ApplicationArea = All;
                        Style = StrongAccent;

                    }
                    field("Adjustments (if any)"; "Adjustments (if any)")
                    {
                        ApplicationArea = All;
                        Style = StrongAccent;

                    }
                    field("Dynamic Column 4"; "Dynamic Column 4")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn4;
                        Style = StrongAccent;
                        trigger OnValidate()
                        begin
                            "Kharif Shortfall Qty" := ("Dynamic Column 1" - "Dynamic Column 4" - "Dynamic Column 5") + ("Dynamic Column 2" - "Dynamic Column 6");
                        end;

                    }
                    field("Dynamic Column 5"; "Dynamic Column 5")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn5;
                        Style = StrongAccent;
                        trigger OnValidate()
                        begin
                            "Kharif Shortfall Qty" := ("Dynamic Column 1" - "Dynamic Column 4" - "Dynamic Column 5") + ("Dynamic Column 2" - "Dynamic Column 6");
                            "Dynamic Column 7" := "Dynamic Column 5" + "Dynamic Column 6"

                        end;

                    }
                    field("Dynamic Column 6"; "Dynamic Column 6")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn6;
                        Style = StrongAccent;
                        trigger OnValidate()
                        begin
                            "Kharif Shortfall Qty" := ("Dynamic Column 1" - "Dynamic Column 4" - "Dynamic Column 5") + ("Dynamic Column 2" - "Dynamic Column 6");
                            "Dynamic Column 7" := "Dynamic Column 5" + "Dynamic Column 6"

                        end;

                    }
                    field("Dynamic Column 7"; "Dynamic Column 7")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn7;
                        Style = StrongAccent;

                    }
                    field("Kharif Shortfall Qty"; "Kharif Shortfall Qty")
                    {
                        ApplicationArea = All;
                        Style = StrongAccent;

                    }
                    field("Dynamic Column 8"; "Dynamic Column 8")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn8;
                        Style = StrongAccent;

                    }
                    field("Dynamic Column 9"; "Dynamic Column 9")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn9;
                        Style = StrongAccent;
                        trigger OnValidate()
                        begin

                            "Dynamic Column 11" := "Dynamic Column 9" + "Dynamic Column 10"

                        end;
                    }
                    field("Dynamic Column 10"; "Dynamic Column 10")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn10;
                        Style = StrongAccent;
                        trigger OnValidate()
                        begin

                            "Dynamic Column 11" := "Dynamic Column 9" + "Dynamic Column 10"

                        end;

                    }
                    field("Dynamic Column 11"; "Dynamic Column 11")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,5,,' + Dynamiccolumn11;
                        Style = StrongAccent;

                        trigger OnValidate()
                        begin

                        end;

                    }
                    field("Rabi Shortfall Qty"; "Rabi Shortfall Qty")
                    {
                        ApplicationArea = All;
                        Style = StrongAccent;

                    }


                }


            }

        }

    }
    actions
    {

        area(processing)
        {

            action("Location wise distribution")
            {
                ApplicationArea = all;
                Image = ListPage;
                Caption = 'Location wise distribution';
                RunObject = Page "Location Wise Prod. Dist.";
                RunPageLink = "Production Plan No." = field("Production Plan No."),
                Season = field(Season),
                Variety = field(Variety);

            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        SetColumnCaptions();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        LocationWiseDistr: Record "Location Wise Prod. Dist.";
    begin
        LocationWiseDistr.Reset();
        LocationWiseDistr.SetRange("Production Plan No.", Rec."Production Plan No.");
        LocationWiseDistr.SetRange(Season, Rec.Season);
        LocationWiseDistr.SetRange(Variety, Rec.Variety);
        LocationWiseDistr.Delete();
    end;

    local procedure SetColumnCaptions()
    var
        SeasonMaster1: Record "Season Master";
        SeasonMaster: Array[7] of Record "Season Master";
    begin
        Clear(Dynamiccolumn1);
        Clear(Dynamiccolumn2);
        Clear(Dynamiccolumn3);
        Clear(Dynamiccolumn4);
        Clear(Dynamiccolumn5);
        Clear(Dynamiccolumn6);
        Clear(Dynamiccolumn7);
        Clear(Dynamiccolumn8);
        Clear(Dynamiccolumn9);
        Clear(Dynamiccolumn10);
        Clear(Dynamiccolumn11);
        if Season <> '' then begin
            SeasonMaster1.Reset();
            SeasonMaster1.SetRange("Season Code", Season);
            SeasonMaster1.FindFirst();
            SeasonMaster[1].Reset();
            SeasonMaster[1].SetRange(Sequence, SeasonMaster1.Sequence + 1);
            SeasonMaster[1].FindFirst();
            Dynamiccolumn1 := SeasonMaster[1]."Season Code" + ' ' + 'Sales Plan';
            SeasonMaster[2].Reset();
            SeasonMaster[2].SetRange(Sequence, SeasonMaster[1].Sequence + 1);
            SeasonMaster[2].FindLast();
            Dynamiccolumn2 := SeasonMaster[2]."Season Code" + ' ' + 'Sales Plan';
            SeasonMaster[3].Reset();
            SeasonMaster[3].SetRange(Sequence, SeasonMaster[2].Sequence + 1);
            SeasonMaster[3].FindLast();
            Dynamiccolumn3 := SeasonMaster[3]."Season Code" + ' ' + 'Sales Plan';
            SeasonMaster[4].Reset();
            SeasonMaster[4].SetRange(Sequence, SeasonMaster[1].Sequence - 1);
            SeasonMaster[4].FindLast();
            SeasonMaster[5].Reset();
            SeasonMaster[5].SetRange(Sequence, SeasonMaster[4].Sequence - 1);
            SeasonMaster[5].FindLast();
            Dynamiccolumn4 := 'Inventory in Hand before ' + SeasonMaster[4]."Season Code" + ' Prod. + Inventory Exp. from ' + SeasonMaster[5]."Season Code" + '+' + ' ' + SeasonMaster[4]."Season Code" + ' SR Exp.';
            SeasonMaster[6].Reset();
            SeasonMaster[6].SetRange(Sequence, SeasonMaster[4].Sequence + 1);
            SeasonMaster[6].FindLast();
            Dynamiccolumn5 := SeasonMaster[4]."Season Code" + ' Production Plan for ' + SeasonMaster[6]."Season Code";
            SeasonMaster[7].Reset();
            SeasonMaster[7].SetRange(Sequence, SeasonMaster[4].Sequence + 1);
            SeasonMaster[7].FindLast();
            Dynamiccolumn6 := SeasonMaster[4]."Season Code" + ' Production Plan for ' + SeasonMaster[3]."Season Code";
            Dynamiccolumn7 := 'Total ' + SeasonMaster[4]."Season Code" + ' Production Plan';
            Dynamiccolumn8 := 'Inventory in Hand before ' + SeasonMaster[6]."Season Code" + ' Prod. + Inventory Exp. from ' + SeasonMaster[4]."Season Code" + ' Prod.';
            Dynamiccolumn9 := SeasonMaster[6]."Season Code" + ' Prod. for ' + SeasonMaster[2]."Season Code" + ' Buffer (' + SeasonMaster[2]."Season Code" + ' Sales Plan - Exp. Inventory in Hand before ' + SeasonMaster[6]."Season Code" + ')';
            Dynamiccolumn10 := SeasonMaster[6]."Season Code" + ' Production for ' + SeasonMaster[3]."Season Code";
            Dynamiccolumn11 := 'Total ' + SeasonMaster[6]."Season Code" + ' Production Plan';
        end;
    end;

    var
        Dynamiccolumn1, Dynamiccolumn2, Dynamiccolumn3, Dynamiccolumn4, Dynamiccolumn5, Dynamiccolumn6, Dynamiccolumn7, Dynamiccolumn8, Dynamiccolumn9, Dynamiccolumn10, Dynamiccolumn11 : Text[150];
        MATRIX_CaptionSet: Array[32] of Text[1024];
        MatrixRecord: Record Location;
        MatrixRecords: array[32] of Record Location;
}

