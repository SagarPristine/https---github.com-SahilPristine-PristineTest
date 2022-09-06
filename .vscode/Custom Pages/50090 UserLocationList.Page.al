#pragma warning disable
page 50090 "User Location List"
{
    PageType = List;
    SourceTable = "User Location";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; "Location Code")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Location Name"; "Location Name")
                {
                    ApplicationArea = all;
                }

                field("Create Sales Order"; "Create Sales Order")
                {
                    ApplicationArea = all;
                }
                field("Transfer From"; "Transfer From")
                {
                    ApplicationArea = all;
                }
                field("Transfer To"; "Transfer To")
                {
                    ApplicationArea = all;
                }
                field("Create Sales Invoice"; "Create Sales Invoice")
                {
                    ApplicationArea = all;
                }
                field("View Sales Order"; "View Sales Order")
                {
                    ApplicationArea = all;
                }
                field("View Sales Invoice"; "View Sales Invoice")
                {
                    ApplicationArea = all;
                }
                field("Create Sales Credit memo"; "Create Sales Credit memo")
                {
                    ApplicationArea = all;
                }
                field("Create Sales Blanket Order"; "Create Sales Blanket Order")
                {
                    ApplicationArea = all;
                }
                field("Create Sales Return order"; "Create Sales Return order")
                {
                    ApplicationArea = all;
                }
                field("View Sales Credit memo"; "View Sales Credit memo")
                {
                    ApplicationArea = all;
                }
                field("View Sales Blanket Order"; "View Sales Blanket Order")
                {
                    ApplicationArea = all;
                }
                field("View Sales Return order"; "View Sales Return order")
                {
                    ApplicationArea = all;
                }
                field("Create Sales Quote"; "Create Sales Quote")
                {
                    ApplicationArea = all;
                }
                field("View Sales Quote"; "View Sales Quote")
                {
                    ApplicationArea = all;
                }
                field("Create Purchase Invoice"; "Create Purchase Invoice")
                {
                    ApplicationArea = all;
                }
                field("View Purchase Invoice"; "View Purchase Invoice")
                {
                    ApplicationArea = all;
                }
                field("Create Purchase Credit memo"; "Create Purchase Credit memo")
                {
                    ApplicationArea = all;
                }
                field("Create Purchase Blanket Order"; "Create Purchase Blanket Order")
                {
                    ApplicationArea = all;
                }
                field("Create Purchase Return order"; "Create Purchase Return order")
                {
                    ApplicationArea = all;
                }
                field("View Purchase Credit memo"; "View Purchase Credit memo")
                {
                    ApplicationArea = all;
                }
                field("View Purchase Blanket Order"; "View Purchase Blanket Order")
                {
                    ApplicationArea = all;
                }
                field("View Purchase Return order"; "View Purchase Return order")
                {
                    ApplicationArea = all;
                }
                field("Create Purchase Quote"; "Create Purchase Quote")
                {
                    ApplicationArea = all;
                }
                field("View Purchase Quote"; "View Purchase Quote")
                {
                    ApplicationArea = all;
                }
                field("GJT General"; "GJT General")
                {
                    ApplicationArea = all;
                }
                field("GJT Sales"; "GJT Sales")
                {
                    ApplicationArea = all;
                }
                field("GJT Purchases"; "GJT Purchases")
                {
                    ApplicationArea = all;
                }
                field("GJT Cash Receipts"; "GJT Cash Receipts")
                {
                    ApplicationArea = all;
                }
                field("GJT Payments"; "GJT Payments")
                {
                    ApplicationArea = all;
                }
                field("GJT Assets"; "GJT Assets")
                {
                    ApplicationArea = all;
                }
                field("GJT TDS Adjustments"; "GJT TDS Adjustments")
                {
                    ApplicationArea = all;
                }
                field("GJT LC"; "GJT LC")
                {
                    ApplicationArea = all;
                }
                field("GJT Receipts"; "GJT Receipts")
                {
                    ApplicationArea = all;
                }
                field("GJT JV"; "GJT JV")
                {
                    ApplicationArea = all;
                }
                field("GJT StdPayments"; "GJT StdPayments")
                {
                    ApplicationArea = all;
                }
                field("IJT Item"; "IJT Item")
                {
                    ApplicationArea = all;
                }
                field("IJT Transfer"; "IJT Transfer")
                {
                    ApplicationArea = all;
                }
                field("IJT Phys. Inventory"; "IJT Phys. Inventory")
                {
                    ApplicationArea = all;
                }
                field("IJT Revaluation"; "IJT Revaluation")
                {
                    ApplicationArea = all;
                }
                field("IJT Consumption"; "IJT Consumption")
                {
                    ApplicationArea = all;
                }
                field("IJT Output"; "IJT Output")
                {
                    ApplicationArea = all;
                }
                field("IJT Capacity"; "IJT Capacity")
                {
                    ApplicationArea = all;
                }
                field("Create Indent"; "Create Indent")
                {
                    ApplicationArea = all;
                }
                field("View Indent"; "View Indent")
                {
                    ApplicationArea = all;
                }
                field("Sales Shipment"; "Sales Shipment")
                {
                    ApplicationArea = all;
                }
                field(Purchaser; Purchaser)
                {
                    ApplicationArea = all;
                }
                field("RGP IN"; "RGP IN")
                {
                    ApplicationArea = all;
                }
                field("RGP OUT"; "RGP OUT")
                {
                    ApplicationArea = all;
                }
                field("View Export Order"; "View Export Order")
                {
                    ApplicationArea = all;
                }
                field("Create Export Order"; "Create Export Order")
                {
                    ApplicationArea = all;
                }
                field("Main Location"; "Main Location")
                {
                    ApplicationArea = all;
                }
                field("View Import Order"; "View Import Order")
                {
                    ApplicationArea = all;
                }
                field("Create Import Order"; "Create Import Order")
                {
                    ApplicationArea = all;
                }
                field("Purchase Receipt"; "Purchase Receipt")
                {
                    ApplicationArea = all;
                }
                field("Sales Invoice"; "Sales Invoice")
                {
                    ApplicationArea = all;
                }
                field("Sales Credit Memo"; "Sales Credit Memo")
                {
                    ApplicationArea = all;
                }
                field("Sales Return Shipment"; "Sales Return Shipment")
                {
                    ApplicationArea = all;
                }
                field("Purchase Invoice"; "Purchase Invoice")
                {
                    ApplicationArea = all;
                }
                field("Purchase Credit Memo"; "Purchase Credit Memo")
                {
                    ApplicationArea = all;
                }
                field("Purchase Return Shipment"; "Purchase Return Shipment")
                {
                    ApplicationArea = all;
                }
                field("Archive Requisition"; "Archive Requisition")
                {
                    ApplicationArea = all;
                }
                field("View Purchase Receipt"; "View Purchase Receipt")
                {
                    ApplicationArea = all;
                }
                field("Posted Transfer Shipment"; "Posted Transfer Shipment")
                {
                    ApplicationArea = all;
                }
                field("Posted Transfer Receipts"; "Posted Transfer Receipts")
                {
                    ApplicationArea = all;
                }
                field("Change Dim. For TO"; "Change Dim. For TO")
                {
                    ApplicationArea = all;
                }
                field("View Transfer Shipment"; "View Transfer Shipment")
                {
                    ApplicationArea = all;
                }
                field("View Transfer Receipt"; "View Transfer Receipt")
                {
                    ApplicationArea = all;
                }
                field("Create Transfer Order"; "Create Transfer Order")
                {
                    ApplicationArea = all;
                }
                field(BomJnl; BomJnl)
                {
                    ApplicationArea = all;
                }
                field("Post Credit Memo"; "Post Credit Memo")
                {
                    ApplicationArea = all;
                }
                field("Damage Stock Authority"; "Damage Stock Authority")
                {
                    ApplicationArea = all;
                }
                field("Sales Order Reopen"; "Sales Order Reopen")
                {
                    ApplicationArea = all;
                }
                field("Cancel Reservation"; "Cancel Reservation")
                {
                    ApplicationArea = all;
                }
                field("Purchase Order Released"; "Purchase Order Released")
                {
                    ApplicationArea = all;
                }
                field("Released P.O."; "Released P.O.")
                {
                    ApplicationArea = all;
                }

                field("Create Purchase Order"; "Create Purchase Order")
                {
                    ApplicationArea = all;
                }
                field("View Purchase Order"; "View Purchase Order")
                {
                    ApplicationArea = all;
                }
                field("Grower Master"; "Grower Master")
                {
                    ApplicationArea = all;
                }
                field("Process Header"; "Process Header")
                {
                    ApplicationArea = all;
                }
                field("Process Invoice Header"; "Process Invoice Header")
                {
                    ApplicationArea = all;
                }
                field("Planting List"; "Planting List")
                {
                    ApplicationArea = all;
                }

                field("Org Gate Entry Outward"; "Org Gate Entry Outward")
                {
                    ApplicationArea = all;
                }
                field("BT Testing Master"; "BT Testing Master")
                {
                    ApplicationArea = all;
                }
                field("Retest Master"; "Retest Master")
                {
                    ApplicationArea = all;
                }
                field(Blend; Blend)
                {
                    ApplicationArea = all;
                }
                field(BSIO; BSIO)
                {
                    ApplicationArea = all;
                }
                field(FSIO; FSIO)
                {
                    ApplicationArea = all;
                }
                field("Seed Arrival FSIO"; "Seed Arrival FSIO")
                {
                    ApplicationArea = all;
                }
                field("Seed Arrival Hybrid"; "Seed Arrival Hybrid")
                {
                    ApplicationArea = all;
                }
                field("View Grower Master"; "View Grower Master")
                {
                    ApplicationArea = all;
                }
                field("View Process Header"; "View Process Header")
                {
                    ApplicationArea = all;
                }
                field("View Process Invoice Header"; "View Process Invoice Header")
                {
                    ApplicationArea = all;
                }
                field("View Planting List"; "View Planting List")
                {
                    ApplicationArea = all;
                }

                field("View Org Gate Entry Outward"; "View Org Gate Entry Outward")
                {
                    ApplicationArea = all;
                }
                field("View Got Testing Master"; "View Got Testing Master")
                {
                    ApplicationArea = all;
                }
                field("View BT Testing Master"; "View BT Testing Master")
                {
                    ApplicationArea = all;
                }
                field("View Retest Master"; "View Retest Master")
                {
                    ApplicationArea = all;
                }
                field("View Blend"; "View Blend")
                {
                    ApplicationArea = all;
                }
                field("View BSIO"; "View BSIO")
                {
                    ApplicationArea = all;
                }
                field("View FSIO"; "View FSIO")
                {
                    ApplicationArea = all;
                }
                field("View Seed Arrival FSIO"; "View Seed Arrival FSIO")
                {
                    ApplicationArea = all;
                }
                field("View Seed Arrival Hybrid"; "View Seed Arrival Hybrid")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry Inward"; "Gate Entry Inward")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry Outward"; "Gate Entry Outward")
                {
                    ApplicationArea = all;
                }
                field("View Gate Entry Inward"; "View Gate Entry Inward")
                {
                    ApplicationArea = all;
                }
                field("View Gate Entry Outward"; "View Gate Entry Outward")
                {
                    ApplicationArea = all;
                }
                field("Crop Master"; "Crop Master")
                {
                    ApplicationArea = all;
                }
                field("Crop Stage Master"; "Crop Stage Master")
                {
                    ApplicationArea = all;
                }
                field("Season Master"; "Season Master")
                {
                    ApplicationArea = all;
                }
                field("Item Group Master"; "Item Group Master")
                {
                    ApplicationArea = all;
                }
                field("Geographical Setup"; "Geographical Setup")
                {
                    ApplicationArea = all;
                }
                field("Party Master"; "Party Master")
                {
                    ApplicationArea = all;
                }
                field("Zone Master"; "Zone Master")
                {
                    ApplicationArea = all;
                }
                field("Taluka Master"; "Taluka Master")
                {
                    ApplicationArea = all;
                }
                field("Region Master"; "Region Master")
                {
                    ApplicationArea = all;
                }
                field("District Master"; "District Master")
                {
                    ApplicationArea = all;
                }
                field("Parent Seed Master"; "Parent Seed Master")
                {
                    ApplicationArea = all;
                }
                field("Lot Range Master"; "Lot Range Master")
                {
                    ApplicationArea = all;
                }
                field("View Crop Master"; "View Crop Master")
                {
                    ApplicationArea = all;
                }
                field("View Crop Stage Master"; "View Crop Stage Master")
                {
                    ApplicationArea = all;
                }
                field("View Season Master"; "View Season Master")
                {
                    ApplicationArea = all;
                }
                field("View Item Group Master"; "View Item Group Master")
                {
                    ApplicationArea = all;
                }
                field("View Geographical Setup"; "View Geographical Setup")
                {
                    ApplicationArea = all;
                }
                field("View Party Master"; "View Party Master")
                {
                    ApplicationArea = all;
                }
                field("View Zone Master"; "View Zone Master")
                {
                    ApplicationArea = all;
                }
                field("View Taluka Master"; "View Taluka Master")
                {
                    ApplicationArea = all;
                }
                field("View Region Master"; "View Region Master")
                {
                    ApplicationArea = all;
                }
                field("View District Master"; "View District Master")
                {
                    ApplicationArea = all;
                }
                field("View Parent Seed Master"; "View Parent Seed Master")
                {
                    ApplicationArea = all;
                }
                field("View Lot Range Master"; "View Lot Range Master")
                {
                    ApplicationArea = all;
                }
                field("State Master"; "State Master")
                {
                    ApplicationArea = all;
                }
                field("View State Master"; "View State Master")
                {
                    ApplicationArea = all;
                }
                field("Location Master"; "Location Master")
                {
                    ApplicationArea = all;
                }
                field("View Location Master"; "View Location Master")
                {
                    ApplicationArea = all;
                }
                field("Germination Determination"; "Germination Determination")
                {
                    ApplicationArea = all;
                }
                field("Physical Purity Determination"; "Physical Purity Determination")
                {
                    ApplicationArea = all;
                }
                field("Moisture Determination"; "Moisture Determination")
                {
                    ApplicationArea = all;
                }
                field("Vigour Test"; "Vigour Test")
                {
                    ApplicationArea = all;
                }
                field("View Germination Determination"; "View Germination Determination")
                {
                    ApplicationArea = all;
                }
                field("View Physical Purity Deter."; "View Physical Purity Deter.")
                {
                    ApplicationArea = all;
                }
                field("View Moisture Determination"; "View Moisture Determination")
                {
                    ApplicationArea = all;
                }
                field("View Vigour Test"; "View Vigour Test")
                {
                    ApplicationArea = all;
                }
                field("QC Result Declaration"; "QC Result Declaration")
                {
                    ApplicationArea = all;
                }
                field("View QC Result Declaration"; "View QC Result Declaration")
                {
                    ApplicationArea = all;
                }
                field("Organizer Arrival"; "Organizer Arrival")
                {
                    ApplicationArea = all;
                }
                field("View Organizer Arrival"; "View Organizer Arrival")
                {
                    ApplicationArea = all;
                }
                field("Organizer Process Transfer"; "Organizer Process Transfer")
                {
                    ApplicationArea = all;
                }
                field("View Organizer Process Trnsfr"; "View Organizer Process Trnsfr")
                {
                    ApplicationArea = all;
                }
                field("Delivery Order"; "Delivery Order")
                {
                    ApplicationArea = all;
                }
                field("View Delivery Order"; "View Delivery Order")
                {
                    ApplicationArea = all;
                }
                field("Marketing Indent"; "Marketing Indent")
                {
                    ApplicationArea = all;
                }
                field("View Marketing Indent"; "View Marketing Indent")
                {
                    ApplicationArea = all;
                }
                field("Hybrid Sales Order"; "Hybrid Sales Order")
                {
                    ApplicationArea = all;
                }
                field("View Hybrid Sales Order"; "View Hybrid Sales Order")
                {
                    ApplicationArea = all;
                }
                field(Cartage; Cartage)
                {
                    ApplicationArea = all;
                }

                field("View Cartage"; "View Cartage")
                {
                    ApplicationArea = all;
                }
                field("Non Seed Indent"; "Non Seed Indent")
                {
                    ApplicationArea = all;
                }
                field("View Non Seed Indent"; "View Non Seed Indent")
                {
                    ApplicationArea = all;
                }
                field("View Posted BSIO"; "View Posted BSIO")
                {
                    ApplicationArea = all;
                }
                field("View Posted FSIO"; "View Posted FSIO")
                {
                    ApplicationArea = all;
                }
                field("View Posted Hybrid Sales Ordr"; "View Posted Hybrid Sales Ordr")
                {
                    ApplicationArea = all;
                }
                field("View Posted Seed Arrival"; "View Posted Seed Arrival")
                {
                    ApplicationArea = all;
                }
                field("View Posted Planting List"; "View Posted Planting List")
                {
                    ApplicationArea = all;
                }
                field("View Posted Hybrid Seed Arrvl"; "View Posted Hybrid Seed Arrvl")
                {
                    ApplicationArea = all;
                }
                field("View Posted Nursery"; "View Posted Nursery")
                {
                    ApplicationArea = all;
                }
                field("View Posted Vegetative"; "View Posted Vegetative")
                {
                    ApplicationArea = all;
                }
                field("View Posted Isolation"; "View Posted Isolation")
                {
                    ApplicationArea = all;
                }
                field("View Posted Pre Flowering"; "View Posted Pre Flowering")
                {
                    ApplicationArea = all;
                }

                field("View Posted Got"; "View Posted Got")
                {
                    ApplicationArea = all;
                }
                field("View Posted BT/Elisa"; "View Posted BT/Elisa")
                {
                    ApplicationArea = all;
                }
                field("View Posted Blend"; "View Posted Blend")
                {
                    ApplicationArea = all;
                }
                field("View Posted Germination Deter."; "View Posted Germination Deter.")
                {
                    ApplicationArea = all;
                }
                field("View Posted PPD"; "View Posted PPD")
                {
                    ApplicationArea = all;
                }
                field("View Posted Moisture Deter."; "View Posted Moisture Deter.")
                {
                    ApplicationArea = all;
                }
                field("View Posted Vigour Test"; "View Posted Vigour Test")
                {
                    ApplicationArea = all;
                }
                field("View Posted QC Declara."; "View Posted QC Declara.")
                {
                    ApplicationArea = all;
                }
                field("View Posted Retest"; "View Posted Retest")
                {
                    ApplicationArea = all;
                }
                field("View Posted Org. Arrival"; "View Posted Org. Arrival")
                {
                    ApplicationArea = all;
                }
                field("View Posted Org. Process Trnfr"; "View Posted Org. Process Trnfr")
                {
                    ApplicationArea = all;
                }
                field("View Posted Org. OGE"; "View Posted Org. OGE")
                {
                    ApplicationArea = All;

                }
                field("View Posted Marketing Indent"; "View Posted Marketing Indent")
                {
                    ApplicationArea = All;
                }
                field("View Posted Delivery Order"; "View Posted Delivery Order")
                {
                    ApplicationArea = All;
                }
                field("View Posted Cartage"; "View Posted Cartage")
                {
                    ApplicationArea = All;
                }
                field("View Posted Non Seed Indent"; "View Posted Non Seed Indent")
                {
                    ApplicationArea = All;
                }
                field(RVD; RVD)
                {
                    ApplicationArea = All;
                }
                field("View RVD"; "View RVD")
                {
                    ApplicationArea = All;
                }
                field("View Posted RVD"; "View Posted RVD")
                {
                    ApplicationArea = All;
                }
                field("App Order"; "App Order")
                {
                    ApplicationArea = All;
                }
                field("View App Order"; "View App Order")
                {
                    ApplicationArea = All;
                }
                field("View Posted App Order"; "View Posted App Order")
                {
                    ApplicationArea = All;
                }
                field("App Event"; "App Event")
                {
                    ApplicationArea = All;
                }
                field("View App Event"; "View App Event")
                {
                    ApplicationArea = All;
                }
                field("View Posted App Event"; "View Posted App Event")
                {
                    ApplicationArea = All;
                }
                field("App Travel"; "App Travel")
                {
                    ApplicationArea = All;
                }
                field("View App Travel"; "View App Travel")
                {
                    ApplicationArea = All;
                }
                field("View Posted App Travel"; "View Posted App Travel")
                {
                    ApplicationArea = All;
                }
                field("Sucker Receipt"; "Sucker Receipt")
                {
                    ApplicationArea = All;
                }
                field("View Sucker Receipt"; "View Sucker Receipt")
                {
                    ApplicationArea = All;
                }
                field("View Posted Sucker Receipt"; "View Posted Sucker Receipt")
                {
                    ApplicationArea = All;
                }

                field("View Posted Tissue Culture PT"; "View Posted Tissue Culture PT")
                {
                    ApplicationArea = All;
                }

                field("View Posted Tissue Culture Ct."; "View Posted Tissue Culture Ct.")
                {
                    ApplicationArea = All;
                }
                field("Post Non Seed Indent"; "Post Non Seed Indent")
                {
                    ApplicationArea = All;
                }
                field(RIB; RIB)
                {
                    ApplicationArea = All;
                }
                field("View RIB"; "View RIB")
                {
                    ApplicationArea = All;
                }
                field(NAOH; NAOH)
                {
                    ApplicationArea = All;
                }
                field(EC; EC)
                {
                    ApplicationArea = All;
                }
                field("Chlorophyll Test"; "Chlorophyll Test")
                {
                    ApplicationArea = All;
                }
                field("Soil Emergence"; "Soil Emergence")
                {
                    ApplicationArea = All;
                }
                field(AAT; AAT)
                {
                    ApplicationArea = All;
                }
                field("HT herbicide tolerance"; "HT herbicide tolerance")
                {
                    ApplicationArea = All;
                }
                field("Phenol Test"; "Phenol Test")
                {
                    ApplicationArea = All;
                }

                field("Land Lease"; "Land Lease")
                {
                    ApplicationArea = All;
                }
                field("View Land Lease"; "View Land Lease")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order"; "Transfer Order")
                {
                    ApplicationArea = All;
                }
                field("View Transfer Order"; "View Transfer Order")
                {
                    ApplicationArea = All;
                }
                field(VWQP; VWQP)
                {
                    ApplicationArea = All;
                }
                field("View VWQP"; "View VWQP")
                {
                    ApplicationArea = All;
                }
                field("Got Testing Master"; "Got Testing Master")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Upload User Location")
            {
                Image = Process;

                trigger OnAction()
                begin
                    XMLPORT.RUN(50029, TRUE);
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*IF USERID = 'TEST' THEN
          editableTrue := TRUE
        ELSE
          editableTrue := FALSE;
          */

    end;

    var
        editableTrue: Boolean;
}

