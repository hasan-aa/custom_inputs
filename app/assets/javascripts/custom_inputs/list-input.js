//= require ./custom_inputs

class ListModifier {
    static removeFromArrayInput(button) {
        button.parentElement.parentElement.remove();
    }

// Add item button click
    static addToItems(e) {
        e.preventDefault;

        let add_button = this;
        if (add_button.classList.contains('array-action--add')) {
            let container = add_button.parentElement.parentElement;
            let item_table = container.querySelector('.item-table tbody');
            let template_row = container.querySelector('.item-row');

            //Get selected values
            let quantity_val = container.querySelector('input').value;
            let item_val = JSON.parse(container.querySelector('select').value);
            let row_id = 'row_' + item_val['id'];

            //If this item is selected before, we'll update it's quantity instead of inserting a new row.
            let row_to_be_updated = item_table.querySelector('#' + row_id);

            let new_row = false;
            if (!row_to_be_updated) {
                //Clone the item row and show it.
                row_to_be_updated = template_row.cloneNode(true);
                row_to_be_updated.classList.remove('hidden');
                row_to_be_updated.setAttribute('id', row_id);
                new_row = true;
            }

            // Find elements to manipulate.
            // Html td cells contain field attributes with the key of contained value.
            let fields = row_to_be_updated.querySelectorAll('td[field]');
            fields.forEach(field => {
                let fieldKey = field.getAttribute('field');
                let fieldValue = item_val[fieldKey];

                //        Put value in table cell
                let cell = row_to_be_updated.querySelector('.' + fieldKey + '-cell');
                cell.innerHTML = fieldValue;

                //        put value in hidden input
                let hidden_input = row_to_be_updated.querySelector('.hidden-' + fieldKey);
                hidden_input.value = fieldValue;
            });

            //Assign selected quantity to hidden inputs#
            let hidden_quantity = row_to_be_updated.querySelector('.hidden-quantity');
            let prev_quantity = hidden_quantity.value || 0;

            quantity_val = Number(quantity_val) + Number(prev_quantity);
            hidden_quantity.value = quantity_val;

            //Show selected quantity on table
            let quantity_cell = row_to_be_updated.querySelector('.quantity-cell');
            quantity_cell.innerHTML = quantity_val;

            if (new_row) {
                //Add cloned row to table
                return item_table.appendChild(row_to_be_updated);
            }
        } else {
            return removeFromArrayInput(this);
        }
    }
}

$(document).ready(function () {
    $('.item-list-container').on('click', '.js-remove-from-items-input', function (e) {
        e.preventDefault();
        ListModifier.removeFromArrayInput(this);
    });

    $('.js-add-to-items-input').click(ListModifier.addToItems);
});