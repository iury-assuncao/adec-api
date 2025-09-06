/*
  Warnings:

  - You are about to drop the column `sector_id` on the `users` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."users" DROP CONSTRAINT "users_sector_id_fkey";

-- AlterTable
ALTER TABLE "public"."users" DROP COLUMN "sector_id";
