# Frog Protocols for Wayland 🐸

**Let's create Wayland Protocols but much more iterative.**

## Manifesto

Wayland Protocols has long had a problem with new protocols sitting for months, to years at a time for even basic functionality.

This is hugely problematic when some protocols implement very primitive and basic functionality such as `frog-fifo-v1`, which is needed for VSync to not cause GPU starvation under Wayland and also fix the dreaded application freezing when windows are occluded with FIFO/VSync enabled.

We **need** to get protocols into end-users hands quicker! The main reason many users are still using X11 is because of missing functionality that we can be shipping today, but is blocked for one reason or another.

## How do I submit a protocol?

Basic ground rules:

 - Have a client
 - Have a server (compositor)
 - Protocols that could *potentially* apply to more than one client only
    - Eg. if this protocol is internal to a compositor and some debug client, it's probably not a good fit here.
    - Nobody is going to be super picky about this, just use common sense.

We want this to be usable by clients, in the real world, so we need to lay out how we are going to iterate with that in mind:

Because this is much more iterative, we won't replace protocols whenever we need to iterate, but simply add `method_v2` or `event_v2` and keep supporting both methods or events, and wrap old methods to new ones in the compositor.

We will only add a whole new `protocol_v2` if something is totally broken beyond repair. We will never figure this out if we don't ship it and experiment! Not every client cares about every edge case or colour of bike shed.

### Support Guidance

**As a server**: If you implemented a protocol for here, and it has been superceded by a protocol in [Wayland Protocols](https://gitlab.freedesktop.org/wayland/wayland-protocols), it is still advisable to keep the Frog Protocols variant implemented if possible, simply because it reduces the churn that end users might face while clients transition.

**As a client**: You should never expect that any protocols in this repo are available. This rule will definitely get broken, but #IToldYouSo.
 - Definitely do not expect that for brand new protocols that might undergo rapid iterations.
 - Definitely do not expect that in your proprietary client.
