/*
  Warnings:

  - You are about to drop the column `createdAt` on the `addresses` table. All the data in the column will be lost.
  - You are about to drop the column `zipCode` on the `addresses` table. All the data in the column will be lost.
  - You are about to drop the column `addressId` on the `churches` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `churches` table. All the data in the column will be lost.
  - You are about to drop the column `addressId` on the `members` table. All the data in the column will be lost.
  - You are about to drop the column `baptismDate` on the `members` table. All the data in the column will be lost.
  - You are about to drop the column `birthDate` on the `members` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `members` table. All the data in the column will be lost.
  - You are about to drop the column `sectorId` on the `members` table. All the data in the column will be lost.
  - You are about to drop the column `addressId` on the `sectors` table. All the data in the column will be lost.
  - You are about to drop the column `churchId` on the `sectors` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `sectors` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `sectorId` on the `users` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[address_id]` on the table `churches` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[address_id]` on the table `members` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[address_id]` on the table `sectors` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `zip_code` to the `addresses` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sector_id` to the `members` table without a default value. This is not possible if the table is not empty.
  - Added the required column `church_id` to the `sectors` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sector_id` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."churches" DROP CONSTRAINT "churches_addressId_fkey";

-- DropForeignKey
ALTER TABLE "public"."members" DROP CONSTRAINT "members_addressId_fkey";

-- DropForeignKey
ALTER TABLE "public"."members" DROP CONSTRAINT "members_sectorId_fkey";

-- DropForeignKey
ALTER TABLE "public"."sectors" DROP CONSTRAINT "sectors_addressId_fkey";

-- DropForeignKey
ALTER TABLE "public"."sectors" DROP CONSTRAINT "sectors_churchId_fkey";

-- DropForeignKey
ALTER TABLE "public"."users" DROP CONSTRAINT "users_sectorId_fkey";

-- DropIndex
DROP INDEX "public"."churches_addressId_key";

-- DropIndex
DROP INDEX "public"."members_addressId_key";

-- DropIndex
DROP INDEX "public"."sectors_addressId_key";

-- AlterTable
ALTER TABLE "public"."addresses" DROP COLUMN "createdAt",
DROP COLUMN "zipCode",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "zip_code" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."churches" DROP COLUMN "addressId",
DROP COLUMN "createdAt",
ADD COLUMN     "address_id" TEXT,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "public"."members" DROP COLUMN "addressId",
DROP COLUMN "baptismDate",
DROP COLUMN "birthDate",
DROP COLUMN "createdAt",
DROP COLUMN "sectorId",
ADD COLUMN     "address_id" TEXT,
ADD COLUMN     "baptism_date" TIMESTAMP(3),
ADD COLUMN     "birth_date" TIMESTAMP(3),
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "sector_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."sectors" DROP COLUMN "addressId",
DROP COLUMN "churchId",
DROP COLUMN "createdAt",
ADD COLUMN     "address_id" TEXT,
ADD COLUMN     "church_id" TEXT NOT NULL,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "public"."users" DROP COLUMN "createdAt",
DROP COLUMN "sectorId",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "sector_id" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "churches_address_id_key" ON "public"."churches"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "members_address_id_key" ON "public"."members"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "sectors_address_id_key" ON "public"."sectors"("address_id");

-- AddForeignKey
ALTER TABLE "public"."churches" ADD CONSTRAINT "churches_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "public"."addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."sectors" ADD CONSTRAINT "sectors_church_id_fkey" FOREIGN KEY ("church_id") REFERENCES "public"."churches"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."sectors" ADD CONSTRAINT "sectors_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "public"."addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."members" ADD CONSTRAINT "members_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "public"."sectors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."members" ADD CONSTRAINT "members_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "public"."addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "public"."sectors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
