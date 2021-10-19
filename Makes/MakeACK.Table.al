table 50001 "Make ACK"
{
    Access = Internal;
    Extensible = false;
    Caption = 'Make';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
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