/*
 * controller.h
 *
 *  Created on: Dec 4, 2013
 *      Author: parrosam
 */

#ifndef CONTROLLER_H_
#define CONTROLLER_H_

#include <inttypes.h>

uint8_t getA(uint32_t buttons);

uint8_t getB(uint32_t buttons);

uint8_t getX(uint32_t buttons);

uint8_t getY(uint32_t buttons);

uint8_t getStart(uint32_t buttons);

uint8_t getL(uint32_t buttons);

uint8_t getR(uint32_t buttons);

uint8_t getZ(uint32_t buttons);

uint8_t getDUP(uint32_t buttons);

uint8_t getDDOWN(uint32_t buttons);

uint8_t getDRIGHT(uint32_t buttons);

uint8_t getDLEFT(uint32_t buttons);

uint8_t getJoyX(uint32_t buttons);

uint8_t getJoyY(uint32_t buttons);

void printButtons(uint32_t buttonPack);

#endif /* CONTROLLER_H_ */
