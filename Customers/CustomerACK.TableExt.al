tableextension 50000 "Customer ACK" extends Customer
{
    fields
    {
        field(50000; "No. of Cars"; Integer)
        {
            Caption = 'No. of Cars';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Car ACK" where("Customer No." = Field("No.")));
        }
    }
}
