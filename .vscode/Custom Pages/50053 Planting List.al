page 50053 "Planting List"
{
    CardPageID = "Planting List Card";
    Editable = true;
    PageType = List;
    SourceTable = "Planting List Header";
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Season; rec.Season)
                {
                    ApplicationArea = all;
                }

                field("Production Centre"; rec."Production Centre")
                {
                    ApplicationArea = all;
                }
                field("Production Centre Name"; rec."Production Centre Name")
                {
                    ApplicationArea = all;
                }
                field("Total Sowing Area In R"; rec."Total Sowing Area In R")
                {
                    ApplicationArea = all;
                }
                field("Total Land in R"; rec."Total Land in R")
                {
                    ApplicationArea = all;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Uploader Planting")
            {
                Caption = 'Uploader Planting';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    XMLPORT.RUN(50008, TRUE);
                    CurrPage.UPDATE;
                end;
            }
        }
        // area(reporting)
        // {
        //     action("Planting Report")
        //     {
        //         Image = "report";
        //         RunObject = Report 50041;
        //         Visible = false;
        //     }
        //     action("Planting List Report")
        //     {
        //         Caption = 'ORG-GRO-STATE-VARIETY WISE PLANTING';
        //         Image = "Report";
        //         RunObject = Report 50050;
        //         Visible = false;
        //     }
        //     action("ORG-GRO-STATE-VrtY  plntg sumry")
        //     {
        //         Caption = 'ORG-GRO-STATE-VARIETY WISE PLANTING SUMMARY';
        //         Image = "report";
        //         RunObject = Report 50132;
        //     }
        //     action("Pending Inspection Report")
        //     {
        //         Image = "report";
        //         RunObject = Report 50051;
        //     }
        //     action("Statewise Planting List")
        //     {
        //         Caption = 'STATE-VARIETYWISE DETAILED PLANTING SUMMARY';
        //         Image = "Report";
        //         RunObject = Report 50129;
        //         Visible = false;
        //     }
        //     action("STATE-VARIETYWISE SUMMARY")
        //     {
        //         Caption = 'STATE-VARIETYWISE PLANTING SUMMARY REPORT';
        //         Image = "Report";
        //         RunObject = Report 50130;
        //     }
        // }
    }

    trigger OnDeleteRecord(): Boolean
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        recul: Record "User Location";
    begin

    end;

    trigger OnOpenPage()
    begin

    end;

    var
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        recUL: Record "User Location";
        CanView: Boolean;
        CanInsert: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
}

