# mail merge

Mail Merge is a Clarify Classic Client add-on product.

It is a fairly common requirement that Clarify users would like to perform “mail merge” operations.
Mail Merge is the process of taking a generic template (in this case, in Microsoft Word), and
replacing certain generic variables (or spots to be filled in) with data from a contact, case, quote,
etc. In effect, this personalizes the document with the required data. This product, Mail Merge for
Clarify (or MM), makes this process simple, painless, and quick.

For example, it might be useful to have a mail merge that when a button is pressed on the case
form that a form letter is filled in with the customer’s name, address, case title, owner, etc. Or, on
a quote form it might be helpful to have a mail merge automatically build a quote, including
header information, and a table of line items, prices, and discounts, all read from the database.

Many Clarify customers have written customized code to fit this mail merge need. While this
works, it is unsatisfying, because it is specific to the one mail merge operation being performed.
When another mail merge is required, more custom coding must be performed. Any time an
existing mail merge needs to be tailored, more customization is required.

What customers have requested is the ability to have a generic mail merge. In other words, an
easy to use mechanism that would allow for administrators to quickly add new mail merge items,
simply by creating a template in Microsoft Word, by manipulating a simple GUI, and by adding a
button (or menu, or dropdown list) to start the mail merge process.

The first component of this is the ability, via a GUI, to specify mail merge profiles. These profiles
include a root (base) object, and a set of variables that are data items from that object and/or
from related objects. Any time a new variable is needed for a mail merge, the administrator only
has to add it in the GUI.

For example, a profile might be driven off of the case table. There might be variables defined for
the case ID number, the case title, the contact’s first name, last name, and phone number. The
case type, priority, and severity may all be used as well. In addition, the case’s activity history
might be a variable, so it can be displayed.

The second component of a generic mail merge is the creation of a Word template. This Mail
Merge For Clarify defines a very simple syntax for variables that you insert into your Word
document. When the mail merge process happens, each variable that is found is replaced with
the proper data from the root object (or related object), as determined by the profile variables.

In the example above, a variable called ID_NUMBER might be defined in the profile. If the mail
merge process found that variable in the Word document, it would know to look at the variable
defined in the profile. In this case, the variable simply uses the id_number field of the case. The
value for the id_number for the case is then placed in the Word document, replacing the variable
name.

The final element of a generic mail merge is the ability to call on the mail merge process from any
form in Clarify. This is accomplished by providing the administrator, in the product, a new API
called mail_merge. This is a ClearBasic API that can be placed in the code for any form (Clarifydefined, or user-defined) in the thick client GUI. The API is simple. It requires a root object objid
(which object is the mail merge based on), a profile name (to know the variables to substitute), a
document template (the Word document to merge), and an output file name (the name when
complete). It also has a variety of other flags to determine specific behavior. The API is
documented in detail later in this manual.

## Documentation

Documentation is located in the docs directory
