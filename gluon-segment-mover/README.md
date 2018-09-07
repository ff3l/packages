gluon-segment-mover
============

Requests Nodes to change to another domain_code

GLUON_SITE_FEEDS="ff3l"<br>
PACKAGES_FF3L_REPO=https://github.com/ff3l/packages<br>
PACKAGES_FF3L_COMMIT=*/missing/*<br>
PACKAGES_FF3L_BRANCH=master<br>

Then add the package *gluon-segment-mover* to site.mk


Cronjob that asks a Director Server, if the Node should move to another Segment.
This is mainly for Migration purposes when Domainsplits are done and can be
removed from the firmware when everything is done.

UCI Keys:
- gluon.core.ignorerelocate='1': Ignore Domain Change requests
- gluon.core.noautodomain='1': Don't switch Domain according to geo coordinates
- gluon.core.domain: Node Domain Code

Status:

Currently edit the relocator.lua file and let it point to a Script on a webserver, that simply returns the desired domain_code as defined in the Gluon Config for that nodeid. For the Moment I don't include a Backend for that. This will happen later perhaps.

A very Simple Script would look like:

```
<?php
$relocator = array (
        '0019995f8a79' => 'ffrgb_uml',
        'a42bb0d87a00' => 'ffrgb_cty', #test
        '60e3279fc038' => 'ffrgb_uml', #LQ_FahrschuleHofer_01
        'a42bb0c920e0' => 'ffrgb_uml', #LQ_FahrschuleHofer_02 VPN
        '60e327ceea24' => 'ffrgb_uml'
);
if (!isset($relocator[$_GET['nodeid']])) {
        echo "noop";
} else {
        echo $relocator[$_GET['nodeid']];
}
?>

```
.. but you are free to get this Database driven or whatever..
