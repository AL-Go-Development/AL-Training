table 50003 "Model ACK"
{
    Access = Internal;
    Extensible = false;
    Caption = 'Model';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Make Code"; Code[20])
        {
            Caption = 'Make Code';
            TableRelation = "Make ACK";
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Body Type"; Enum "Body Type ACK")
        {
            Caption = 'Body';
            DataClassification = CustomerContent;
        }
        field(5; "Engine Type"; Enum "Engine Type ACK")
        {
            Caption = 'Engine';
            DataClassification = CustomerContent;
        }
        field(6; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code", "Make Code")
        {
            Clustered = true;
        }
    }
}