;================================================================================================================================================================================================
;
;   ./s
;
;   This file contains structures pertinent to the entire codebase.
;
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;   Symbolic Cross-Referencing
;
;   No external references.
;

;================================================================================================================================================================================================
;
;   Egg Data Structure
;

    struc egg
      .passphrase                         resb        28h ; Storage for passphrase associated with the egg.

      .item.id                            resd  00000001h ; Item id associated with egg.

      .area.id                            resd  00000001h ; Area id associated with egg.

      .name.l                             resb        01h ; Length of egg's name.
      .name                               resb        28h ; Name of the gylf living in the egg.

      .i.parent.name.l                    resb        01h ; Length of egg's inseminating parent's name.
      .i.parent.name                      resb        28h ; Name of egg's inseminating parent.

      .i.parent.base.color                resb        01h ; Byte indicator for base color.
      .i.parent.secondary.color           resb        01h ; Byte indicator for secondary color.

      .i.parent.base.fur.quality          resb        01h ; Byte indicator for base fur quality.
      .i.parent.secondary.fur.quality     resb        01h ; Byte indicator for secondary fur quality.

      .i.parent.strength                  resb        01h ; Byte indicator for participant strength.
      .i.parent.endurance                 resb        01h ; Byte indicator for participant endurance.
      .i.parent.agility                   resb        01h ; Byte indicator for participant agility.

      .e.parent.name.l                    resb        01h ; Length of egg's laying parent's name.
      .e.parent.name                      resb        28h ; Name of egg's laying parent.

      .e.parent.base.color                resb        01h ; Byte indicator for base color.
      .e.parent.secondary.color           resb        01h ; Byte indicator for secondary color.

      .e.parent.base.fur.quality          resb        01h ; Byte indicator for base fur quality.
      .e.parent.secondary.fur.quality     resb        01h ; Byte indicator for secondary fur quality.

      .e.parent.strength                  resb        01h ; Byte indicator for participant strength.
      .e.parent.endurance                 resb        01h ; Byte indicator for participant endurance.
      .e.parent.agility                   resb        01h ; Byte indicator for participant agility.

      .connection.descriptor.index        resd  00000001h ; Placeholder for connection descriptor.
      .connection.external.index          resd  00000001h ; Placeholder for external descriptor.
      .connection.status.index            resb        01h ; Placeholder for status.
    endstruc

;================================================================================================================================================================================================
;
;   Gylf Data Structure
;

    struc gylf
      .passphrase                         resb        28h ; Buffer for passphrase associated with this gylf.

      .base.color                         resb        01h ; Byte indicator for base color.
      .secondary.color                    resb        01h ; Byte indicator for secondary color.

      .base.fur.quality                   resb        01h ; Byte indicator for base fur quality.
      .secondary.fur.quality              resb        01h ; Byte indicator for secondary fur quality.

      .strength                           resb        01h ; Byte indicator for participant strength.
      .endurance                          resb        01h ; Byte indicator for participant endurance.
      .agility                            resb        01h ; Byte indicator for participant agility.

      .name.l                             resb        01h ; Byte indicator for length of gylf's name.
      .name                               resb        28h ; Buffer for the name of this gylf.

      .e.parent.name.l                    resb        01h ; Byte indicator for length of laying parent's name.
      .e.parent.name                      resb        28h ; Buffer for the name of the participant's laying parent.

      .i.parent.name.l                    resb        01h ; Byte indicator for length of inseminating parent's name.
      .i.parent.name                      resb        28h ; Buffer for the name of the participant's inseminating parent.

      .age                                resd  00000001h ; Dword indicator for participant age.

      .egg.readiness                      resb        01h ; Byte indicator for egg readiness.      

      .pouch                              resd  00000001h ; Dword placeholder for area id correspondent to participant's pouch.
      .location.id                        resd  00000001h ; Dword indicator for area id.

      .right.ear.wound.level              resb        01h ; Byte indicator for right ear wound level.
      .left.ear.wound.level               resb        01h ; Byte indicator for left ear wound level.
      .right.eye.wound.level              resb        01h ; Byte indicator for right eye wound level.
      .left.eye.wound.level               resb        01h ; Byte indicator for left eye wound level.
      .scalp.wound.level                  resb        01h ; Byte indicator for scalp wound level.
      .right.cheek.wound.level            resb        01h ; Byte indicator for right cheek wound level.
      .left.cheek.wound.level             resb        01h ; Byte indicator for left cheek wound level.
      .nose.wound.level                   resb        01h ; Byte indicator for nose wound level.
      .chin.wound.level                   resb        01h ; Byte indicator for chin wound level.
      .neck.wound.level                   resb        01h ; Byte indicator for neck wound level.
      .right.shoulder.wound.level         resb        01h ; Byte indicator for right shoulder wound level.
      .left.shoulder.wound.level          resb        01h ; Byte indicator for left shoulder wound level.
      .right.upper.arm.wound.level        resb        01h ; Byte indicator for right upper arm wound level.
      .left.upper.arm.wound.level         resb        01h ; Byte indicator for left upper arm wound level.
      .right.forearm.wound.level          resb        01h ; Byte indicator for right forearm wound level.
      .left.forearm.wound.level           resb        01h ; Byte indicator for left forearm wound level.
      .right.wrist.wound.level            resb        01h ; Byte indicator for right wrist wound level.
      .left.wrist.wound.level             resb        01h ; Byte indicator for left wrist wound level.
      .right.hand.wound.level             resb        01h ; Byte indicator for right hand wound level.
      .left.hand.wound.level              resb        01h ; Byte indicator for left hand wound level.
      .right.index.finger.wound.level     resb        01h ; Byte indicator for right index finger wound level.
      .right.middle.finger.wound.level    resb        01h ; Byte indicator for right middle finger wound level.
      .right.ring.finger.wound.level      resb        01h ; Byte indicator for right ring finger wound level.
      .right.thumb.wound.level            resb        01h ; Byte indicator for right thumb wound level.
      .left.index.finger.wound.level      resb        01h ; Byte indicator for left index finger wound level.
      .left.middle.finger.wound.level     resb        01h ; Byte indicator for left middle finger wound level.
      .left.ring.finger.wound.level       resb        01h ; Byte indicator for left ring finger wound level.
      .left.thumb.wound.level             resb        01h ; Byte indicator for left thumb wound level.
      .right.chest.wound.level            resb        01h ; Byte indicator for right chest wound level.
      .left.chest.wound.level             resb        01h ; Byte indicator for left chest wound level.
      .back.wound.level                   resb        01h ; Byte indicator for back wound level.
      .abdomen.wound.level                resb        01h ; Byte indicator for abdomen wound level.
      .pouch.wound.level                  resb        01h ; Byte indicator for pouch wound level.
      .right.outside.thigh.wound.level    resb        01h ; Byte indicator for right outside thigh wound level.
      .right.inside.thigh.wound.level     resb        01h ; Byte indicator for right inside thigh wound level.
      .left.outside.thigh.wound.level     resb        01h ; Byte indicator for left outside thigh wound level.
      .left.inside.thigh.wound.level      resb        01h ; Byte indicator for left inside thigh wound level.
      .right.lower.leg.wound.level        resb        01h ; Byte indicator for right lower leg wound level.
      .left.lower.leg.wound.level         resb        01h ; Byte indicator for left lower leg wound level.
      .right.dew.talon.wound.level        resb        01h ; Byte indicator for right dew talon wound level.
      .right.main.fore.talon.wound.level  resb        01h ; Byte indicator for right main fore talon wound level.
      .right.middle.talon.wound.level     resb        01h ; Byte indicator for right middle talon wound level.
      .right.low.talon.wound.level        resb        01h ; Byte indicator for right low talon wound level.
      .left.dew.talon.wound.level         resb        01h ; Byte indicator for left dew talon wound level.
      .left.main.fore.talon.wound.level   resb        01h ; Byte indicator for left main fore talon wound level.
      .left.middle.talon.wound.level      resb        01h ; Byte indicator for left middle talon wound level.
      .left.low.talon.wound.level         resb        01h ; Byte indicator for left low talon wound level.

      .brain.wound.level                  resb        01h ; Byte indicator for brain wound level.
      .neck.spinal.wound.level            resb        01h ; Byte indicator for neck spinal wound level.
      .back.spinal.wound.level            resb        01h ; Byte indicator for back spinal wound level.
      .heart.wound.level                  resb        01h ; Byte indicator for heart wound level.
      .right.lung.wound.level             resb        01h ; Byte indicator for right lung wound level.
      .left.lung.wound.level              resb        01h ; Byte indicator for left lung wound level.
      .liver.wound.level                  resb        01h ; Byte indicator for liver wound level.
      .stomach.wound.level                resb        01h ; Byte indicator for stomach wound level.
      .large.intestine.wound.level        resb        01h ; Byte indicator for large intestine wound level.
      .small.intestine.wound.level        resb        01h ; Byte indicator for small intestine wound level.
      .ovary.wound.level                  resb        01h ; Byte indicator for ovary wound level.
      .testicle.wound.level               resb        01h ; Byte indicator for testicle wound level.
      .inseminator.wound.level            resb        01h ; Byte indicator for inseminator wound level.

      .head.worn.item.id                  resd  00000001h ; Item id for item worn on head.
      .right.ear.worn.item.id             resd  00000001h ; Item id for item worn on right ear.
      .left.ear.worn.item.id              resd  00000001h ; Item id for item worn on left ear.
      .neck.worn.item.id                  resd  00000001h ; Item id for item worn on neck.
      .chest.worn.item.id                 resd  00000001h ; Item id for item worn on chest.
      .back.worn.item.id                  resd  00000001h ; Item id for item worn on back.
      .abdomen.worn.item.id               resd  00000001h ; Item id for item worn on abdomen.
      .right.thigh.worn.item.id           resd  00000001h ; Item id for item worn on right thigh.
      .left.thigh.worn.item.id            resd  00000001h ; Item id for item worn on left thigh.

      .right.hand.inventory.id            resd  00000001h ; Item id for item held in right hand.
      .left.hand.inventory.id             resd  00000001h ; Item id for item held in left hand.

      .administrative.byte                resb        01h ; Reserved for administrative data

      .connection.area.id.index           resd  00000001h ; Placeholder for connection area id.
      .connection.descriptor.index        resd  00000001h ; Placeholder for connection descriptor.
      .connection.external.index          resd  00000001h ; Placeholder for external descriptor.
      .connection.status.index            resb        01h ; Placeholder for status.
    endstruc

;================================================================================================================================================================================================
;
;   Ghost Data Structure
;

    struc ghost
    endstruc
