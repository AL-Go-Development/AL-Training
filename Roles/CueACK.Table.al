table 50099 "Cue ACK"
{
    Access = Internal;
    Extensible = false;

    Caption = 'Cue';

    fields
    {
        field(1; PK; Code[1])
        {
            DataClassification = SystemMetadata;
        }
        field(4; "Cars Last 7 Days Filter"; DateTime)
        {
            FieldClass = FlowFilter;
        }
        field(5; "Cars Last 7 Days"; Integer)
        {
            Caption = 'Last 7 Days';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purchase Header" where(SystemCreatedAt = field("Cars Last 7 Days Filter")));
        }
        field(6; "Cars Last 31 Days Filter"; DateTime)
        {
            FieldClass = FlowFilter;
        }
        field(7; "Cars Last 31 Days"; Integer)
        {
            Caption = 'Last 31 Days';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purchase Header" where(SystemCreatedAt = field("Cars Last 31 Days Filter")));
        }
        field(8; "Cars Last 12 Months Filter"; DateTime)
        {
            FieldClass = FlowFilter;
        }

        field(9; "Cars Last 12 Months"; Integer)
        {
            Caption = 'Last 12 Months';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purchase Header" where(SystemCreatedAt = field("Cars Last 12 Months Filter")));
        }
    }


    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetFilter("Cars Last 7 Days Filter", '%1..%2', CreateDateTime(CalcDate('<-1W>', WorkDate()), Time()), CurrentDateTime());
        SetFilter("Cars Last 31 Days Filter", '%1..%2', CreateDateTime(CalcDate('<-1M>', WorkDate()), Time()), CurrentDateTime());
        SetFilter("Cars Last 12 Months Filter", '%1..%2', CreateDateTime(CalcDate('<-1Y>', WorkDate()), Time()), CurrentDateTime());
    end;
}