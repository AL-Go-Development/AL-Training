table 50002 "Setup ACK"
{
    Access = Internal;
    Extensible = false;
    Caption = 'Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[1])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Car Nos."; Code[10])
        {
            Caption = 'Car Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(3; "Attachment Nos."; Code[10])
        {
            Caption = 'Attachment Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}