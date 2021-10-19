table 50000 "Car ACK"
{
    Access = Internal;
    Extensible = false;
    Caption = 'Car';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Setup: Record "Setup ACK";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    Setup.Get();
                    Setup.TestField("Car Nos.");

                    NoSeriesManagement.TestManual(Setup."Car Nos.");
                end;
            end;
        }
        field(2; VIN; Text[17])
        {
            Caption = 'VIN';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Blob)
        {
            Caption = 'Description';
            Subtype = Memo;
            DataClassification = CustomerContent;
        }
        field(4; "Make Code"; Code[20])
        {
            Caption = 'Make Code';
            NotBlank = true;
            TableRelation = "Make ACK";
            DataClassification = CustomerContent;
        }
        field(5; "Make Description"; Text[50])
        {
            Caption = 'Make';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Make ACK".Description where("Code" = field("Make Code")));
        }
        field(6; "Model Code"; Code[20])
        {
            Caption = 'Model Code';
            NotBlank = true;
            TableRelation = "Model ACK" where("Make Code" = field("Make Code"));
            DataClassification = CustomerContent;
        }
        field(7; "Model Description"; Text[50])
        {
            Caption = 'Model';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Model ACK".Description where("Make Code" = field("Make Code"), "Code" = field("Model Code")));
        }
        field(8; "Body Type"; Enum "Body Type ACK")
        {
            Caption = 'Body';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Model ACK"."Body Type" where("Make Code" = field("Make Code"), "Code" = field("Model Code")));
        }
        field(9; "Engine Type"; Enum "Engine Type ACK")
        {
            Caption = 'Engine';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Model ACK"."Engine Type" where("Make Code" = field("Make Code"), "Code" = field("Model Code")));
        }
        field(10; "Weight"; Decimal)
        {
            Caption = 'Weight';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Model ACK".Weight where("Make Code" = field("Make Code"), "Code" = field("Model Code")));
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(12; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Setup: Record "Setup ACK";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            Setup.Get();
            Setup.TestField("Car Nos.");

            NoSeriesManagement.InitSeries(Setup."Car Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    trigger OnDelete()
    var
        Attachment: Record "Attachment ACK";
    begin
        Attachment.SetRange("Car No.", "No.");
        Attachment.DeleteAll(true);
    end;

    internal procedure TakePicture()
    var
        Attachment: Record "Attachment ACK";
    begin
        Attachment.ImportFromCamera(Rec);
    end;

    internal procedure GetDescription(): Text
    var
        TempBlobHelper: Record "Blob Helper ACK" temporary;
    begin
        Rec.CalcFields(Rec.Description);
        TempBlobHelper.Init();
        TempBlobHelper.Blob := Rec.Description;
        exit(TempBlobHelper.ReadAsText());
    end;

    internal procedure SetDescription(Description: Text)
    var
        TempBlobHelper: Record "Blob Helper ACK" temporary;
    begin
        TempBlobHelper.Init();
        TempBlobHelper.WriteAsText(Description);
        Rec."Description" := TempBlobHelper."Blob";
        Rec.Modify(true);
    end;
}