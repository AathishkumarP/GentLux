document.addEventListener("DOMContentLoaded", function () {

    // =========================================================
    // ELEMENTS
    // =========================================================

    const sizeButtons =
        document.querySelectorAll(".size-button");

    const quantityMinus =
        document.querySelector(".quantity-minus");

    const quantityPlus =
        document.querySelector(".quantity-plus");

    const quantityDisplay =
        document.getElementById("productQuantity");

    const selectedVariantId =
        document.getElementById("selectedVariantId");

    const selectedQuantity =
        document.getElementById("selectedQuantity");
		
	const buyNowQuantity =
		    document.getElementById("buyNowQuantity");

	const buyNowForm =
		    document.getElementById("buyNowForm");

	const buyNowVariantId =
		    document.getElementById("buyNowVariantId");

    const addToCartForm =
        document.getElementById("addToCartForm");

    const addToCartButton =
        document.querySelector(".add-to-cart-button");


    // =========================================================
    // STATE
    // =========================================================

    let quantity = 1;

    let selectedStock = 0;

    let sizeSelected = false;


    // =========================================================
    // INITIAL STATE
    // =========================================================

    updateQuantityDisplay();

    if (addToCartButton) {
        addToCartButton.disabled = true;
    }


    // =========================================================
    // SIZE SELECTION
    // =========================================================

    sizeButtons.forEach(function (button) {

        button.addEventListener(
            "click",
            function () {

                if (button.disabled) {
                    return;
                }


                // Remove previous selection
                sizeButtons.forEach(
                    function (sizeButton) {

                        sizeButton.classList.remove(
                            "selected"
                        );

                    }
                );


                // Select current size
                button.classList.add(
                    "selected"
                );


                // Read selected variant
                const variantId =
                    button.getAttribute(
                        "data-variant-id"
                    );


                const stock =
                    parseInt(
                        button.getAttribute(
                            "data-stock"
                        ),
                        10
                    );


                // Store selected variant
                selectedVariantId.value =
                    variantId;


                selectedStock =
                    isNaN(stock)
                        ? 0
                        : stock;


                sizeSelected = true;


                // Reset quantity whenever size changes
                quantity = 1;

                updateQuantityDisplay();


                // Enable add to cart
                if (
                    addToCartButton
                    && selectedStock > 0
                ) {

                    addToCartButton.disabled =
                        false;

                }

            }
        );

    });


    // =========================================================
    // MINUS
    // =========================================================

    if (quantityMinus) {

        quantityMinus.addEventListener(
            "click",
            function () {

                if (quantity > 1) {

                    quantity--;

                    updateQuantityDisplay();

                }

            }
        );

    }


    // =========================================================
    // PLUS
    // =========================================================

    if (quantityPlus) {

        quantityPlus.addEventListener(
            "click",
            function () {

                if (!sizeSelected) {

                    showSizeMessage();

                    return;
                }


                if (quantity < selectedStock) {

                    quantity++;

                    updateQuantityDisplay();

                }

            }
        );

    }


    // =========================================================
    // UPDATE QUANTITY
    // =========================================================

    function updateQuantityDisplay() {

        if (quantityDisplay) {

            quantityDisplay.textContent =
                quantity;

        }


        if (selectedQuantity) {

            selectedQuantity.value =
                quantity;

        }
		
		if (buyNowQuantity) {

		    buyNowQuantity.value =
		        quantity;

		}


        // Disable minus at quantity 1
        if (quantityMinus) {

            quantityMinus.disabled =
                quantity <= 1;

        }


        // Disable plus when stock reached
        if (quantityPlus) {

            quantityPlus.disabled =
                !sizeSelected
                || selectedStock <= 0
                || quantity >= selectedStock;

        }

    }


    // =========================================================
    // ADD TO CART VALIDATION
    // =========================================================

    if (addToCartForm) {

        addToCartForm.addEventListener(
            "submit",
            function (event) {

                if (
                    !sizeSelected
                    || !selectedVariantId.value
                ) {

                    event.preventDefault();

                    showSizeMessage();

                    return;
                }


                if (
                    selectedStock <= 0
                ) {

                    event.preventDefault();

                    alert(
                        "This size is currently out of stock."
                    );

                    return;
                }


                if (
                    quantity < 1
                    || quantity > selectedStock
                ) {

                    event.preventDefault();

                    alert(
                        "Please select a valid quantity."
                    );

                    return;
                }


                // Make absolutely sure submitted
                // quantity is current.
                selectedQuantity.value =
                    quantity;

            }
        );

    }
	
	
	// =========================================================
	// BUY NOW VALIDATION
	// =========================================================

	if (buyNowForm) {

	    buyNowForm.addEventListener(
	        "submit",
	        function (event) {

	            if (
	                !sizeSelected
	                || !buyNowVariantId.value
	            ) {

	                event.preventDefault();

	                showSizeMessage();

	                return;
	            }


	            if (selectedStock <= 0) {

	                event.preventDefault();

	                alert(
	                    "This size is currently out of stock."
	                );

	                return;
	            }


	            if (
	                quantity < 1
	                || quantity > selectedStock
	            ) {

	                event.preventDefault();

	                alert(
	                    "Please select a valid quantity."
	                );

	                return;
	            }


	            buyNowQuantity.value =
	                quantity;

	        }
	    );

	}


    // =========================================================
    // SIZE MESSAGE
    // =========================================================

	function showSizeMessage() {

	    alert(
	        "Please select a size."
	    );

	}

});