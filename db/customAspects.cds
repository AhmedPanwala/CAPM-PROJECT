namespace india.customAspects;

type Gender : String(1) enum {
    male = 'M';
    female = 'F';
    other = 'O';
};

type phonenumber : String(13)
@assert.format: '^(\+91)?[6-9]\d{9}$';

type email : String(30)
@assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

type amountType : Decimal(15, 2);

aspect amount {
    CURRENCY_CODE :String(3);
    GROSS_AMOUNT : amountType;
    NET_AMOUNT :amountType;
    TAX_AMOUNT : amountType;
}
