module sui_contracts::mycoin {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;

    const ICON_URL: vector<u8> = b"https://sandroxd.online/mycon.png";

    struct MYCOIN has drop {}

    fun init(witness: MYCOIN, ctx: &mut TxContext) {
        let icon_url = url::new_unsafe_from_bytes(*&ICON_URL);
        let (treasury, metadata) = coin::create_currency(
          witness,
          18,
          b"MY COIN",
          b"MC",
          b"My first coin in Sui Network",
          option::some(icon_url),
          ctx
        );
        transfer::freeze_object(metadata);
        transfer::transfer(treasury, tx_context::sender(ctx))
    }
}
