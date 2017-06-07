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
      .egg.item.id                                    resd  00000001h       ; Item id associated with egg.

      .egg.area.id                                    resd  00000001h       ; Area id associated with egg.

      .egg.name.l                                     resb  01h             ; Length of egg's name.
      .egg.name                                       resb  28h             ; Name of the gylf living in the egg.

      .egg.e.parent.l                                 resb  01h             ; Length of laying parent's name.
      .egg.e.parent                                   resb  28h             ; Name of laying parent for DNA retrieval.

      .egg.f.parent.l                                 resb  01h             ; Length of fertilizing parent's name.
      .egg.f.parent                                   resb  28h             ; Name of fertilizing parent for DNA retrieval.

      .egg.connection.descriptor.index                resd  00000001h       ; Placeholder for connection descriptor.
      .egg.connection.external.index                  resd  00000001h       ; Placeholder for external descriptor.
      .egg.connection.status.index                    resb  01h             ; Placeholder for status.
    endstruc

;================================================================================================================================================================================================
;
;   Participant Data Structure
;

    struc gylf
      .participant.base.color                         resb  01h             ; Byte indicator for base color.
      .participant.secondary.color                    resb  01h             ; Byte indicator for secondary color.

      .participant.base.fur.quality                   resb  01h             ; Byte indicator for base fur quality.
      .participant.secondary.fur.quality              resb  01h             ; Byte indicator for secondary fur quality.

      .participant.strength                           resb  01h             ; Byte indicator for participant strength.
      .participant.endurance                          resb  01h             ; Byte indicator for participant endurance.
      .participant.agility                            resb  01h             ; Byte indicator for participant agility.

      .participant.name.l                             resb  01h             ; Byte indicator for length of gylf's name.
      .participant.name                               resb  28h             ; Buffer for the name of this gylf.

      .participant.mother.l                           resb  01h             ; Byte indicator for length of mother's name.
      .participant.mother                             resb  28h             ; Buffer for the name of the participant's mother.

      .participant.father.l                           resb  01h             ; Byte indicator for length of father's name.
      .participant.father                             resb  28h             ; Buffer for the name of the participant's father.

      .participant.age                                resd  00000001h       ; Dword indicator for participant age.

      .participant.egg.readiness                      resb  01h             ; Byte indicator for egg readiness.      

      .participant.pouch                              resd  00000001h       ; Dword placeholder for area id correspondent to participant's pouch.
      .participant.location.id                        resd  00000001h       ; Dword indicator for area id.

      .participant.right.ear.wound.level              resb  01h             ; Byte indicator for right ear wound level.
      .participant.left.ear.wound.level               resb  01h             ; Byte indicator for left ear wound level.
      .participant.right.eye.wound.level              resb  01h             ; Byte indicator for right eye wound level.
      .participant.left.eye.wound.level               resb  01h             ; Byte indicator for left eye wound level.
      .participant.scalp.wound.level                  resb  01h             ; Byte indicator for scalp wound level.
      .participant.right.cheek.wound.level            resb  01h             ; Byte indicator for right cheek wound level.
      .participant.left.cheek.wound.level             resb  01h             ; Byte indicator for left cheek wound level.
      .participant.nose.wound.level                   resb  01h             ; Byte indicator for nose wound level.
      .participant.chin.wound.level                   resb  01h             ; Byte indicator for chin wound level.
      .participant.neck.wound.level                   resb  01h             ; Byte indicator for neck wound level.
      .participant.right.shoulder.wound.level         resb  01h             ; Byte indicator for right shoulder wound level.
      .participant.left.shoulder.wound.level          resb  01h             ; Byte indicator for left shoulder wound level.
      .participant.right.upper.arm.wound.level        resb  01h             ; Byte indicator for right upper arm wound level.
      .participant.left.upper.arm.wound.level         resb  01h             ; Byte indicator for left upper arm wound level.
      .participant.right.forearm.wound.level          resb  01h             ; Byte indicator for right forearm wound level.
      .participant.left.forearm.wound.level           resb  01h             ; Byte indicator for left forearm wound level.
      .participant.right.wrist.wound.level            resb  01h             ; Byte indicator for right wrist wound level.
      .participant.left.wrist.wound.level             resb  01h             ; Byte indicator for left wrist wound level.
      .participant.right.hand.wound.level             resb  01h             ; Byte indicator for right hand wound level.
      .participant.left.hand.wound.level              resb  01h             ; Byte indicator for left hand wound level.
      .participant.right.index.finger.wound.level     resb  01h             ; Byte indicator for right index finger wound level.
      .participant.right.middle.finger.wound.level    resb  01h             ; Byte indicator for right middle finger wound level.
      .participant.right.ring.finger.wound.level      resb  01h             ; Byte indicator for right ring finger wound level.
      .participant.right.thumb.wound.level            resb  01h             ; Byte indicator for right thumb wound level.
      .participant.left.index.finger.wound.level      resb  01h             ; Byte indicator for left index finger wound level.
      .participant.left.middle.finger.wound.level     resb  01h             ; Byte indicator for left middle finger wound level.
      .participant.left.ring.finger.wound.level       resb  01h             ; Byte indicator for left ring finger wound level.
      .participant.left.thumb.wound.level             resb  01h             ; Byte indicator for left thumb wound level.
      .participant.right.chest.wound.level            resb  01h             ; Byte indicator for right chest wound level.
      .participant.left.chest.wound.level             resb  01h             ; Byte indicator for left chest wound level.
      .participant.back.wound.level                   resb  01h             ; Byte indicator for back wound level.
      .participant.abdomen.wound.level                resb  01h             ; Byte indicator for abdomen wound level.
      .participant.pouch.wound.level                  resb  01h             ; Byte indicator for pouch wound level.
      .participant.right.outside.thigh.wound.level    resb  01h             ; Byte indicator for right outside thigh wound level.
      .participant.right.inside.thigh.wound.level     resb  01h             ; Byte indicator for right inside thigh wound level.
      .participant.left.outside.thigh.wound.level     resb  01h             ; Byte indicator for left outside thigh wound level.
      .participant.left.inside.thigh.wound.level      resb  01h             ; Byte indicator for left inside thigh wound level.
      .participant.right.lower.leg.wound.level        resb  01h             ; Byte indicator for right lower leg wound level.
      .participant.left.lower.leg.wound.level         resb  01h             ; Byte indicator for left lower leg wound level.
      .participant.right.dew.talon.wound.level        resb  01h             ; Byte indicator for right dew talon wound level.
      .participant.right.main.fore.talon.wound.level  resb  01h             ; Byte indicator for right main fore talon wound level.
      .participant.right.middle.talon.wound.level     resb  01h             ; Byte indicator for right middle talon wound level.
      .participant.right.low.talon.wound.level        resb  01h             ; Byte indicator for right low talon wound level.
      .participant.left.dew.talon.wound.level         resb  01h             ; Byte indicator for left dew talon wound level.
      .participant.left.main.fore.talon.wound.level   resb  01h             ; Byte indicator for left main fore talon wound level.
      .participant.left.middle.talon.wound.level      resb  01h             ; Byte indicator for left middle talon wound level.
      .participant.left.low.talon.wound.level         resb  01h             ; Byte indicator for left low talon wound level.

      .participant.brain.wound.level                  resb  01h             ; Byte indicator for brain wound level.
      .participant.neck.spinal.wound.level            resb  01h             ; Byte indicator for neck spinal wound level.
      .participant.back.spinal.wound.level            resb  01h             ; Byte indicator for back spinal wound level.
      .participant.heart.wound.level                  resb  01h             ; Byte indicator for heart wound level.
      .participant.right.lung.wound.level             resb  01h             ; Byte indicator for right lung wound level.
      .participant.left.lung.wound.level              resb  01h             ; Byte indicator for left lung wound level.
      .participant.liver.wound.level                  resb  01h             ; Byte indicator for liver wound level.
      .participant.stomach.wound.level                resb  01h             ; Byte indicator for stomach wound level.
      .participant.large.intestine.wound.level        resb  01h             ; Byte indicator for large intestine wound level.
      .participant.small.intestine.wound.level        resb  01h             ; Byte indicator for small intestine wound level.
      .participant.ovary.wound.level                  resb  01h             ; Byte indicator for ovary wound level.
      .participant.testicle.wound.level               resb  01h             ; Byte indicator for testicle wound level.
      .participant.inseminator.wound.level            resb  01h             ; Byte indicator for inseminator wound level.

      .head.worn.item.id                              resd  00000001h       ; Item id for item worn on head.
      .right.ear.worn.item.id                         resd  00000001h       ; Item id for item worn on right ear.
      .left.ear.worn.item.id                          resd  00000001h       ; Item id for item worn on left ear.
      .neck.worn.item.id                              resd  00000001h       ; Item id for item worn on neck.
      .chest.worn.item.id                             resd  00000001h       ; Item id for item worn on chest.
      .back.worn.item.id                              resd  00000001h       ; Item id for item worn on back.
      .abdomen.worn.item.id                           resd  00000001h       ; Item id for item worn on abdomen.
      .right.thigh.worn.item.id                       resd  00000001h       ; Item id for item worn on right thigh.
      .left.thigh.worn.item.id                        resd  00000001h       ; Item id for item worn on left thigh.

      .right.hand.inventory.id                        resd  00000001h       ; Item id for item held in right hand.
      .left.hand.inventory.id                         resd  00000001h       ; Item id for item held in left hand.

      .administrative.byte                            resb  01h             ; Reserved for administrative data

      .participant.father.base.color                  resb  01h             ; Byte indicator for base color.
      .participant.father.secondary.color             resb  01h             ; Byte indicator for secondary color.

      .participant.father.base.fur.quality            resb  01h             ; Byte indicator for base fur quality.
      .participant.father.secondary.fur.quality       resb  01h             ; Byte indicator for secondary fur quality.

      .participant.father.strength                    resb  01h             ; Byte indicator for participant strength.
      .participant.father.endurance                   resb  01h             ; Byte indicator for participant endurance.
      .participant.father.agility                     resb  01h             ; Byte indicator for participant agility.

      .participant.mother.base.color                  resb  01h             ; Byte indicator for base color.
      .participant.mother.secondary.color             resb  01h             ; Byte indicator for secondary color.

      .participant.mother.base.fur.quality            resb  01h             ; Byte indicator for base fur quality.
      .participant.mother.secondary.fur.quality       resb  01h             ; Byte indicator for secondary fur quality.

      .participant.mother.strength                    resb  01h             ; Byte indicator for participant strength.
      .participant.mother.endurance                   resb  01h             ; Byte indicator for participant endurance.
      .participant.mother.agility                     resb  01h             ; Byte indicator for participant agility.

      .participant.connection.descriptor.index        resd  00000001h       ; Placeholder for connection descriptor.
      .participant.connection.external.index          resd  00000001h       ; Placeholder for external descriptor.
      .participant.connection.status.index            resb  01h             ; Placeholder for status.
    endstruc

;================================================================================================================================================================================================
;
;   Ghost Data Structure
;

    struc ghost
    endstruc
