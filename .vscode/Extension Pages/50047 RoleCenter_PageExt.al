pageextension 50047 ExtendNavigationArea extends 9022
{

    actions
    {
        addfirst(Sections)
        {
            group("PAN Seed Customize Flow")
            {
                group(Masters)
                {

                    action("Growers")
                    {
                        Caption = 'Growers';
                        Image = SendApprovalRequest;
                        ApplicationArea = All;
                        RunObject = page Growers;
                    }
                    action("Parties")
                    {
                        Image = Customer;
                        ApplicationArea = All;
                        RunObject = page "Party Master List";
                    }
                    action("Parent Seeds")
                    {
                        Image = MarketingSetup;
                        ApplicationArea = All;
                        RunObject = page "Parent Seed List";
                    }
                    action("Crop Stage Master")
                    {
                        ApplicationArea = All;
                        RunObject = page "Crop Stage Master List";
                    }
                    action("Crops")
                    {
                        ApplicationArea = All;
                        RunObject = page "Crop Master";
                    }
                    action(Custom_Customer)
                    {
                        Caption = 'Customers';
                        ApplicationArea = All;
                        RunObject = page "Customer List";
                    }
                    action(Custom_Vendor)
                    {
                        Caption = 'Vendors';
                        ApplicationArea = All;
                        RunObject = page "Vendor List";
                    }
                    action(locations)
                    {
                        ApplicationArea = all;
                        RunObject = page "Location List";
                    }
                    action(Varieties)
                    {
                        ApplicationArea = all;
                        RunObject = page Varieties;

                    }
                    action(Custome_Items)
                    {
                        Caption = 'Items';
                        ApplicationArea = All;
                        RunObject = page "Item List";
                    }
                    action(Zone)
                    {
                        ApplicationArea = All;
                        RunObject = page "Zone List";
                    }
                    action(Region)
                    {
                        ApplicationArea = All;
                        RunObject = page "Region Master";
                    }
                    action(District)
                    {
                        ApplicationArea = All;
                        RunObject = page "District Master";
                    }
                    action(Taluka)
                    {
                        ApplicationArea = All;
                        RunObject = page "Taluka Master";
                    }
                    action(Bardana)
                    {
                        Caption = 'Bardana Adjustment Master';
                        ApplicationArea = all;
                        RunObject = page "Bardana Adjustment Master";
                    }
                    action(InspectionMandatory)
                    {
                        Caption = 'Inspection Mandatory Rules';
                        ApplicationArea = all;
                        RunObject = page "Inspection Mandatory Rules";
                    }

                }
                group("Production Plan")
                {
                    group("Prerequisite Masters")
                    {
                        action("Risk Factors")
                        {
                            ApplicationArea = all;
                            RunObject = page "Risk Factor Master";
                        }
                        action(Seasons)
                        {
                            ApplicationArea = all;
                            RunObject = page "Season Master";
                        }
                    }
                    group("Production Plans")
                    {
                        action("Production Plan List")
                        {
                            ApplicationArea = all;
                            RunObject = page "Production Plan Lists";
                        }
                    }

                }
                group("Production Process")
                {
                    action("Raw Seed Intake")
                    {
                        ToolTip = 'You can do positive adjustment of Breeder and Foundation seeds!';
                        ApplicationArea = all;
                        RunObject = page 40;
                    }
                    action("Process Transfer")
                    {
                        ToolTip = 'Process Transfer from Raw to Packed!';
                        ApplicationArea = all;
                        RunObject = page "Process Transfer List";
                    }
                    action("Delivery Orders")
                    {
                        ApplicationArea = all;
                        RunObject = page "Delivery Sales Orders";
                    }
                    action("Dispatch Challans")
                    {
                        ApplicationArea = all;
                        RunObject = page "Dispach Challan Lists";
                    }

                    group(Planting)
                    {
                        action("Unposted Planting")
                        {
                            Caption = 'Un-posted Planting';
                            ApplicationArea = all;
                            RunObject = page "Planting List";
                        }
                        action("Posted Planting")
                        {
                            Caption = 'Posted Planting';
                            ApplicationArea = all;
                            RunObject = page "Posted Planting List";
                        }

                    }

                    group(Inspections)
                    {
                        group("Unposted Inspection")
                        {
                            action(Nursery)
                            {
                                ApplicationArea = all;
                                RunObject = page "Nursery Inspection I";
                            }
                            action(Vegetative)
                            {
                                ApplicationArea = all;
                                RunObject = page "Vegetative Inspection II List";
                            }
                            action(Isolation)
                            {
                                ApplicationArea = all;
                                RunObject = page "Isolation Inspection III List";
                            }
                            action("Vegetative Roughing")
                            {
                                ApplicationArea = all;
                                RunObject = page "Vegetative Roughing";
                            }
                            action("Pre Flowering Roughing")
                            {
                                ApplicationArea = all;
                                RunObject = page "Pre Flowering Roughing List";
                            }
                            action("Flowering Roughing")
                            {
                                ApplicationArea = all;
                                RunObject = page "Flowering Inspection V";
                            }
                            action("Pollination")
                            {
                                ApplicationArea = all;
                                RunObject = page "Pollination List";
                            }
                            action(MaleChoping)
                            {
                                ApplicationArea = all;
                                RunObject = page "MaleChopping Insp. VI List";
                            }
                            action("Final Roughing")
                            {
                                ApplicationArea = all;
                                RunObject = page "Final Roughing Insp. VII List";
                            }
                            action(Harvesting)
                            {
                                ApplicationArea = all;
                                RunObject = page "Harvesting Insp. VIII List";
                            }
                        }
                        group(PostedInspections)
                        {
                            Caption = 'Posted Inspection';
                            action(PostedNursery)
                            {
                                Caption = 'Nursery';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunPageMode = Create;
                                RunObject = page "Posted Nursery Inspection I";
                            }
                            action(PostedVegetative)
                            {
                                Caption = 'Vegetative';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunObject = page "Posted Vegetative Insp. II";
                            }
                            action(PostedIsolation)
                            {
                                Caption = 'Isolation';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunObject = page "Posted Isolation Insp. III";
                            }

                            action(PostedVegetativeRoughing)
                            {
                                Caption = 'Vegetative Roughing';
                                ApplicationArea = all;
                                RunObject = page "Posted Vegetative Roughing";
                            }
                            action(PostedPollination)
                            {
                                Caption = 'Pollination';
                                ApplicationArea = all;
                                RunObject = page "Posted Pollination List";
                            }
                            action("PostedPre Flowering")
                            {
                                Caption = 'Pre Flowering Roughing';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunObject = page "Posted Pre-Flowering Insp. IV";
                            }
                            action("PostedFlowering")
                            {
                                Caption = 'Flowering Roughing';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunObject = page "Posted Flowering Inspection V";
                            }
                            action(PostedMaleChopping)
                            {
                                Caption = 'MaleChopping';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunObject = page "Posted MaleChopping Insp. VI";
                            }
                            action("PostedFinal Roughing")
                            {
                                Caption = 'Final Roughing';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunObject = page "Posted Final Roughing VII";
                            }
                            action(PostedHarvesting)
                            {
                                Caption = 'Harvesting';
                                Image = TaskQualityMeasure;
                                ApplicationArea = all;
                                RunObject = page "Posted Harvesting Insp. VIII";
                            }

                        }
                    }

                    action(SeedArrival)
                    {
                        Caption = 'Seed Arrival';
                        ApplicationArea = all;
                        RunObject = page "Seed Arrival List";
                    }
                }
                group("QC Process")
                {
                    group("GOT")
                    {
                        action("Pending GOT")
                        {
                            ApplicationArea = all;
                            RunObject = page "Pending Approval FactBox";
                        }
                        action("Posted GOT")
                        {
                            ApplicationArea = all;
                            RunObject = Page "Pending Approval FactBox";

                        }
                    }
                    group("Germination")
                    {
                        action("Pending Germination")
                        {
                            ApplicationArea = all;
                        }
                        action("Posted Germination")
                        {
                            ApplicationArea = all;
                        }
                    }
                }
            }
        }
    }
}