-- Add landlord_cid to track the legal owner of a property (distinct from occupant `owner`)
ALTER TABLE `properties`
    ADD COLUMN IF NOT EXISTS `landlord_cid` VARCHAR(50) NULL;

-- Add foreign key if not already present (ignore errors if FK exists)
ALTER TABLE `properties`
    ADD CONSTRAINT `fk_properties_landlord`
    FOREIGN KEY (`landlord_cid`) REFERENCES `players` (`citizenid`)
    ON DELETE SET NULL;

-- Add index for faster listing/filtering
CREATE INDEX IF NOT EXISTS `idx_properties_landlord` ON `properties` (`landlord_cid`);

-- Backfill existing records: if a property has an owner but no landlord set yet, assume owner is landlord
UPDATE `properties`
SET `landlord_cid` = `owner`
WHERE `landlord_cid` IS NULL AND `owner` IS NOT NULL;

