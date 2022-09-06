tableextension 50064 Salesheader extends "Sales Header"
{
    fields
    {
        field(50000; Zone; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Zone Master".Code;
        }
        field(50001; District; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "District Master".Code;
        }
        field(50002; Region; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Region Master".Code;
        }
        field(50003; Taluka; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Taluka Master".Code;
        }
        field(50005; "Zone Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Zone Master".Description where(Code = field(Zone)));
        }
        field(50006; "Taluka Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Taluka Master".Description where(Code = field(Taluka)));
        }
        field(50007; "Region Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Region Master".Name where(Code = field(Region)));
        }
        field(50008; "District Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("District Master".Name where(Code = field(District)));
        }
        field(50009; Season; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";
        }
        field(50010; "Delivery Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Delivery Sales Header"."No." where(Status = filter(Released));

            trigger OnValidate()
            var
                DeliverySalesHdr: Record "Delivery Sales Header";
            begin

                if DeliverySalesHdr.Get("Delivery Order No") then begin
                    Validate("Sell-to Customer No.", DeliverySalesHdr."Customer No.");
                    Validate("Location Code", DeliverySalesHdr."Location Code");
                end;
            end;

        }
        field(50011; "Transporter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where("Vendor Type" = filter(Transporter));
        }
        field(50018; "Transporter Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Transporter Code")));
            Editable = false;
        }
        field(50012; "Freight Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Advance Amount" := "Freight Amount";
            end;
        }
        field(50013; "Freight Term"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","FOR","Ex-godown";

        }
        field(50014; "Advance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                VALIDATE("Paid by Party", "Freight Amount" - "Advance Amount");
            end;
        }
        field(50015; "Paid by Party"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                VALIDATE("Balance Amount", "Freight Amount" - "Advance Amount" - "Paid by Party");
            end;
        }
        field(50016; "Balance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Driver Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Driver Phone"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Document SubType"; Enum "Document Subtype")
        {
            DataClassification = ToBeClassified;
        }

        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
            begin
                If Cust.get("Sell-to Customer No.") then begin
                    VALIDATE(Zone, Cust.Zone);
                    VALIDATE(Region, Cust.Region);
                    VALIDATE(District, Cust.District);
                    VALIDATE(Taluka, Cust.Taluka);
                end else begin
                    VALIDATE(Zone, '');
                    VALIDATE(Region, '');
                    VALIDATE(District, '');
                    VALIDATE(Taluka, '');
                end;
            end;
        }

    }

    var
        myInt: Integer;
}